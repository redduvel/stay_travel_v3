import 'package:flutter/material.dart';


enum NotificationType {
  warning,
  success,
  information
}


class NotificationCard extends StatelessWidget {
  final NotificationType notificationType;
  final String notificationText;
  
  const NotificationCard({
    super.key, 
    required this.notificationType, 
    required this.notificationText
  });

  @override
  Widget build(BuildContext context) {
    IconData notificationIcon(NotificationType type) => switch (type) {
      NotificationType.warning => Icons.warning_amber_outlined,
      NotificationType.success => Icons.check,
      NotificationType.information => Icons.info_outline
    };

    Icon icon = Icon(notificationIcon(notificationType), color: Colors.white, size: 24);

    Color backgroundColor(NotificationType type) => switch (type) {
      NotificationType.warning => const Color(0xffF4C753),
      NotificationType.success => const Color(0xFF81C00C),
      NotificationType.information => const Color(0xFF7B49E6)
    };

    Color bgColor = backgroundColor(notificationType);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: const BorderRadius.all(Radius.circular(8))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              icon,
              const SizedBox(width: 12),
              SizedBox(
                width: 264,
                child: Text(
                  notificationText,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    color: Colors.white
                  ),
                ),
              )
            ],
          ),
          const Icon(
            Icons.chevron_right,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}