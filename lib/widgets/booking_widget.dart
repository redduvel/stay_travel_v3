import 'package:flutter/material.dart';
import 'package:stay_travel_v3/models/booking.dart';
import 'package:stay_travel_v3/themes/colors.dart';
import 'package:stay_travel_v3/themes/text_styles.dart';

class BookingWidget extends StatefulWidget {
  final Booking booking;
  const BookingWidget({super.key, required this.booking});

  @override
  State<BookingWidget> createState() => _BookingWidgetState();
}

class _BookingWidgetState extends State<BookingWidget> {

  List<Color?> _getColor(String status) {
    switch (status) {
      case "active":
        return [const Color(0xFFE8FEC0), const Color(0xFF81C00C)];
      case "waiting":
        return [const Color(0xFFDFD2FC), const Color(0xFF7B49E6)];
      case "notApproved":
        return [const Color(0xFFFFC8C8), const Color(0xFFE64949)];
      case "completed":
        return [const Color(0xFFFEF1D0), const Color(0xffF4C753)];
      default:
        return [null, null];
    }
  }
  
  Map<String, dynamic> _getBookingStatus(String status) {
     switch (status) {
      case "active":
        return {'status': "Одобрено", 'icon': Icons.done};
      case "waiting":
        return {'status': "В ожидании", 'icon': Icons.timer_sharp};
      case "notApproved":
        return {'status': "Отказано", 'icon': Icons.stop_circle_outlined};
      case "completed":
        return {'status': "Завершено", 'icon': Icons.done_all_outlined};
      default:
        return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _getColor(widget.booking.status)[0],
      child: Padding(
        padding: const EdgeInsets.all(7.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.booking.hotelName!,
              style: AppTextStyles.bodyTextStyle.copyWith(fontSize: 20),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.schedule, color: AppColors.grey2,),
                const SizedBox(width: 5),
                Text(
                  widget.booking.startDate.toString(),
                  style: AppTextStyles.bodyTextStyle.copyWith(fontSize: 16),
                )
              ],
            ),
            const SizedBox(height: 10),
             Row(
              children: [
                const Icon(Icons.pin_drop_outlined, color: AppColors.grey2,),
                const SizedBox(width: 5),
                Text(widget.booking.hotelAddress!,
                style: AppTextStyles.bodyTextStyle.copyWith(fontSize: 16))
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: _getColor(widget.booking.status)[1],
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 2.5, horizontal: 10),
                  child: Row(
                    children: [
                      Icon(_getBookingStatus(widget.booking.status)['icon'], color: AppColors.background,),
                      const SizedBox(width: 5),
                      Text(
                        _getBookingStatus(widget.booking.status)['status'],
                        style: AppTextStyles.bodyTextStyle
                            .copyWith(color: AppColors.background, fontSize: 16),
                      )
                    ],
                  ),
                ),
                const IconButton(icon: Icon(Icons.more_horiz_outlined), onPressed: null,)
              ],
            )
          ],
        ),
      ),
    );
  }
}
