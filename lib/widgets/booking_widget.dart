import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stay_travel_v3/models/booking.dart';
import 'package:stay_travel_v3/themes/colors.dart';
import 'package:stay_travel_v3/themes/text_styles.dart';
import 'package:stay_travel_v3/views/hotel/create_review_page.dart';

class BookingWidget extends StatefulWidget {
  final Booking booking;
  const BookingWidget({super.key, required this.booking});

  @override
  State<BookingWidget> createState() => _BookingWidgetState();
}

class _BookingWidgetState extends State<BookingWidget> {
  String formatDateTime(DateTime dateTime) {
    Intl.defaultLocale = 'ru_RU';

    String formattedDate = DateFormat('d MMMM').format(dateTime);
    String formattedTime = DateFormat('HH:mm').format(dateTime);

    return '$formattedDate, в $formattedTime';
  }

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    String statusText = '';

    switch (widget.booking.status) {
      case 'active':
        statusText = 'Активный';
        statusColor = AppColors.activeBooking;
        break;
      case 'notApproved':
        statusText = 'Отклоненно';
        statusColor = AppColors.notApprovedBooking;
        break;
      case 'completed':
        statusText = 'Завершенный';
        statusColor = AppColors.completedBooking;
      case 'waiting':
        statusText = 'В ожидании';
        statusColor = AppColors.waitingBooking;
      default:
        statusColor = AppColors.grey;
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(7.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.booking.hotelName!,
              style: AppTextStyles.subheaderBoldStyle.copyWith(fontSize: 24),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Icon(
                  Icons.chevron_right,
                  color: AppColors.grey2,
                  size: 32,
                ),
                const SizedBox(width: 5),
                Text(
                  formatDateTime(widget.booking.startDate),
                  style: AppTextStyles.bodyTextStyle.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(
                  Icons.chevron_left,
                  color: AppColors.grey2,
                  size: 32,
                ),
                const SizedBox(width: 5),
                Text(
                  formatDateTime(widget.booking.endDate),
                  style: AppTextStyles.bodyTextStyle.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(
                  Icons.pin_drop_outlined,
                  color: AppColors.grey2,
                  size: 32,
                ),
                const SizedBox(width: 5),
                SizedBox(
                  width: 280,
                  child: Text(widget.booking.hotelAddress!,
                      style:
                          AppTextStyles.bodyTextStyle.copyWith(fontSize: 16)),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Card(
                  margin: const EdgeInsets.all(0),
                  color: statusColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Статус: $statusText',
                      style: const TextStyle(
                          fontSize: 16, color: AppColors.background),
                    ),
                  ),
                ),
                widget.booking.status == 'completed'
                    ? IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return CreateReviewPage(hotelId: widget.booking.hotelId);
                            },
                          );
                        },
                        icon: const Icon(Icons.rate_review_outlined))
                    : const SizedBox.shrink()
              ],
            )
          ],
        ),
      ),
    );
  }
}
