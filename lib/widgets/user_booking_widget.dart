import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:stay_travel_v3/bloc/booking/booking_bloc.dart';
import 'package:stay_travel_v3/bloc/booking/booking_event.dart';
import 'package:stay_travel_v3/bloc/booking/booking_state.dart';
import 'package:stay_travel_v3/models/booking.dart';
import 'package:stay_travel_v3/themes/colors.dart';
import 'package:stay_travel_v3/themes/text_styles.dart';
import 'package:stay_travel_v3/widgets/custom_button.dart';
import 'package:stay_travel_v3/widgets/input_field.dart';

class BookingRequestWidget extends StatelessWidget {
  final Booking booking;

  const BookingRequestWidget({
    super.key,
    required this.booking,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    String statusText = '';

    switch (booking.status) {
      case 'active':
        statusText = 'Активный';
        statusColor = Colors.green;
        break;
      case 'notApproved':
        statusText = 'Отклоненно';
        statusColor = Colors.red;
        break;
      case 'completed':
        statusText = 'Завершенный';
        statusColor = Colors.orange;
      case 'waiting':
        statusText = 'В ожидании';
        statusColor = Colors.purple;
      default:
        statusColor = AppColors.grey;
    }

    return Card(
      margin: const EdgeInsets.all(5),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ID заявки: ${booking.id}',
              style: AppTextStyles.subheaderBoldStyle.copyWith(
                fontSize: 12
              ),
            ),
            Text(
              booking.userIds.length == 1 ? 
              'Клиент: ${booking.userName}' :
              'Клиенты: ${booking.userName}, и еще ${booking.userIds.length}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Отель: ${booking.hotelName}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Дата создания: ${booking.createdAt.toLocal().toShortDateString()}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Дата заезда: ${booking.startDate.toLocal().toShortDateString()}\nДата выезда: ${booking.endDate.toLocal().toShortDateString()}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Сообщение: ${booking.description}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Card(
                  margin: EdgeInsets.all(0),
                  color: statusColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Статус: $statusText',
                      style:
                          TextStyle(fontSize: 16, color: AppColors.background),
                    ),
                  ),
                ),
                Row(
                  children: [
                    IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
                    IconButton(
                      icon: const Icon(Icons.reply),
                      onPressed: () => _showBottomModal(context, booking.id!),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _showBottomModal(BuildContext context, String bookingId) {
    TextEditingController _messageController = TextEditingController();

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return BlocBuilder<BookingBloc, BookingState>(
          builder: (context, state) {
            return Container(
            padding: const EdgeInsets.all(16.0),
            width: double.infinity,
            child: CustomScrollView(
              
              slivers: [
                const SliverToBoxAdapter(
                  child: Text(
                    'Ответить на заявку',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 16)),
                SliverToBoxAdapter(
                  child: TextFormField(
                    controller: _messageController,
                    decoration: textFieldDecoration('Сообщение клиенту'),
                    textAlign: TextAlign.left,
                    textAlignVertical: TextAlignVertical.center,
                    obscureText: true,
                    maxLines: 1,
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 10),
                ),
                 SliverToBoxAdapter(
                    child: CustomButton.load(
                  widget: state is BookingLoading ? LoadingIndicator(indicatorType: Indicator.ballSpinFadeLoader) : Text('Одобрить'),
                  mainAxisAlignment: MainAxisAlignment.center,
                  onPressed: () {
                    context.read<BookingBloc>().add(UpdateBookingStatus(bookingId, 'active'));
                  },
                )),
                 SliverToBoxAdapter(
                    child: CustomButton.load(
                  widget: state is BookingLoading ? LoadingIndicator(indicatorType: Indicator.ballSpinFadeLoader) : Text('Отказать'),
                  mainAxisAlignment: MainAxisAlignment.center,
                  onPressed: () {
                    context.read<BookingBloc>().add(UpdateBookingStatus(bookingId, 'notApproved'));
                  },
                )),
              ],
            ),
          );
          },
        );
      },
    );
  }
}

extension DateExtension on DateTime {
  String toShortDateString() {
    return '${day.toString().padLeft(2, '0')}/${month.toString().padLeft(2, '0')}/$year';
  }
}
