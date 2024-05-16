// Notifications Tab  
import 'package:flutter/material.dart';

class NotificationsTab extends StatefulWidget {
  const NotificationsTab({super.key});

  @override
  State<NotificationsTab> createState() => _NotificationsTabState();
}

class _NotificationsTabState extends State<NotificationsTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Уведомления'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.clear_all)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.done_all))
        ],
        automaticallyImplyLeading: false,
        surfaceTintColor: Colors.white,
      ),
    );
  }
}