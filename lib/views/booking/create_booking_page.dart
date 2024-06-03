// Create Booking Page
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:stay_travel_v3/bloc/auth/auth_bloc.dart';
import 'package:stay_travel_v3/bloc/booking/booking_bloc.dart';
import 'package:stay_travel_v3/bloc/booking/booking_event.dart';
import 'package:stay_travel_v3/models/booking.dart';
import 'package:stay_travel_v3/models/hotel.dart';
import 'package:stay_travel_v3/themes/colors.dart';
import 'package:stay_travel_v3/themes/text_styles.dart';
import 'package:intl/intl.dart';
import 'package:stay_travel_v3/widgets/custom_button.dart';

class CreateBookingPage extends StatefulWidget {
  final Hotel hotel;
  const CreateBookingPage({super.key, required this.hotel});

  @override
  State<CreateBookingPage> createState() => _CreateBookingPageState();
}

class _CreateBookingPageState extends State<CreateBookingPage> {
  DatePeriod _selectedPeriod =
      DatePeriod(DateTime.now(), DateTime.now().add(const Duration(days: 7)));
  final TextEditingController _notesController = TextEditingController();

  String _getWeekDayText(DateTime date, {bool isStart = true}) {
    final now = DateTime.now();
    final weekdaysNominative = [
      'понедельник',
      'вторник',
      'среда',
      'четверг',
      'пятница',
      'суббота',
      'воскресенье'
    ];
    final weekdaysAccusative = [
      'понедельник',
      'вторник',
      'среду',
      'четверг',
      'пятницу',
      'субботу',
      'воскресенье'
    ];
    final nextWeekdays = [
      'следующий понедельник',
      'следующий вторник',
      'следующую среду',
      'следующий четверг',
      'следующую пятницу',
      'следующую субботу',
      'следующее воскресенье'
    ];

    final difference = date.difference(now).inDays;
    if (difference < 7 && date.weekday >= now.weekday) {
      return 'в ближайший ${weekdaysAccusative[date.weekday - 1]}';
    } else if (difference < 14) {
      return 'в ${nextWeekdays[date.weekday - 1]}';
    } else {
      return '${weekdaysNominative[date.weekday - 1]}, ${DateFormat('d MMMM', 'ru').format(date)}';
    }
  }

  String _getFormattedDateRange() {
    final startDateText = _getWeekDayText(_selectedPeriod.start, isStart: true);
    final endDateText = DateFormat('d MMMM', 'ru').format(_selectedPeriod.end);
    final endDateWeekday = DateFormat('EEEE', 'ru').format(_selectedPeriod.end);

    // Handle accusative case for the end date weekday
    final endDateWeekdayAccusative = {
          'понедельник': 'понедельник',
          'вторник': 'вторник',
          'среда': 'среду',
          'четверг': 'четверг',
          'пятница': 'пятницу',
          'суббота': 'субботу',
          'воскресенье': 'воскресенье',
        }[endDateWeekday] ??
        endDateWeekday;

    return 'Вы сможете заехать $startDateText, и выехать в $endDateWeekdayAccusative, $endDateText.';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Создание брони',
          style: AppTextStyles.subheaderStyle,
        ),
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.all(7.5),
          child: Padding(
            padding: const EdgeInsets.all(7.5),
            child: CustomScrollView(
              scrollDirection: Axis.vertical,
              slivers: [
                SliverToBoxAdapter(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(7.5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.hotel.name, style: AppTextStyles.subheaderBoldStyle,),
                          Text('Адрес: ${widget.hotel.address}', style: AppTextStyles.subheaderBoldStyle.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w400
                          )),
                        ],
                      ),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child:SizedBox(height: 10)
                ),
                SliverToBoxAdapter(
                  child: Card(
                    child: Column(
                      children: [
                        const Text(
                          'Выберите период бронирования',
                          style: AppTextStyles.subheaderBoldStyle,
                          textAlign: TextAlign.center,
                        ),
                        RangePicker(
                          datePickerStyles: DatePickerRangeStyles(
                              selectedDateStyle: const TextStyle(
                                  color: AppColors.background, fontSize: 20)),
                          selectedPeriod: _selectedPeriod,
                          onChanged: (DatePeriod newPeriod) {
                            setState(() {
                              _selectedPeriod = newPeriod;
                            });
                          },
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2025),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Text(
                    _getFormattedDateRange(),
                    style: AppTextStyles.subheaderBoldStyle
                        .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 10)),
                SliverToBoxAdapter(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(7.6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Вы можете написать сообщение администратору.', style: AppTextStyles.subheaderBoldStyle.copyWith(
                            fontSize: 18
                          ), textAlign: TextAlign.center,),
                          const SizedBox(height: 10),
                          TextField(
                            controller: _notesController,
                            decoration: const InputDecoration(
                              hintText: 'Дополнительные пожелания...',
                              labelStyle: TextStyle(color: AppColors.orange2),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: AppColors.orange2)),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: AppColors.orange2)),
                            ),
                            maxLines: 3,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 10)),
                SliverToBoxAdapter(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(7.5),
                      child: Text(
                        'Далее с Вами свяжется администратор отеля. Статус бронирования Вы сможете увидеть во вкладке "Бронирования".',
                        style: AppTextStyles.subheaderBoldStyle
                            .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 10)),
                SliverToBoxAdapter(
                  child: CustomButton.normal(
                    text: 'Забронировать',
                    mainAxisAlignment: MainAxisAlignment.center,
                    onPressed: () {
                      final userId = BlocProvider.of<AuthBloc>(context).currentUser!.id;
                      Booking booking = Booking(
                        userId: userId, 
                        hotelId: widget.hotel.id, 
                        createdAt: DateTime.now(), 
                        startDate: _selectedPeriod.start, 
                        endDate: _selectedPeriod.end, 
                        description: _notesController.text, 
                        status: "waiting"
                      );

                      context.read<BookingBloc>().add(CreateBooking(booking));
                    },
                  ),
                )
              ],
            ),
          )),
    );
  }
}
