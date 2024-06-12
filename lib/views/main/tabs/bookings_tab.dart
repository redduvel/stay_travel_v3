// Bookings Tab
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:stay_travel_v3/bloc/booking/booking_bloc.dart';
import 'package:stay_travel_v3/bloc/booking/booking_event.dart';
import 'package:stay_travel_v3/bloc/booking/booking_state.dart';
import 'package:stay_travel_v3/models/booking.dart';
import 'package:stay_travel_v3/models/booking_status.dart';
import 'package:stay_travel_v3/themes/colors.dart';
import 'package:stay_travel_v3/widgets/booking_widget.dart';

class BookingsTab extends StatefulWidget {
  const BookingsTab({super.key});

  @override
  State<BookingsTab> createState() => _BookingsTabState();
}

class _BookingsTabState extends State<BookingsTab> {
  @override
  void initState() {
    if ((context.read<BookingBloc>().state is BookingLoaded) == false) {
      context.read<BookingBloc>().add(FetchUserBookings());
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Ваши бронирования'),
          automaticallyImplyLeading: false,
          surfaceTintColor: Colors.white,
          actions: [
            IconButton(onPressed: () {
              context.read<BookingBloc>().add(FetchUserBookings());
            }, icon: const Icon(Icons.history))
          ],
          bottom: PreferredSize(
              preferredSize: const Size(double.infinity, 60),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                        BookingStatus.bookingStatuses.length,
                        (index) => GestureDetector(
                              onTap: () {},
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 2.5),
                                child: Chip(
                                  label: Text(
                                    BookingStatus.bookingStatuses[index].UIName,
                                    style: const TextStyle(
                                      color: AppColors.black,
                                    ),
                                  ),
                                  backgroundColor: AppColors.grey,
                                  side: BorderSide.none,
                                ),
                              ),
                            )),
                  ),
                ),
              )),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16),
            child: BlocBuilder<BookingBloc, BookingState>(
                builder: (context, state) {
              if (state is BookingLoading) {
                return CustomScrollView(
                  scrollDirection: Axis.vertical,
                  slivers: [
                    SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                      return Skeletonizer(
                        child: BookingWidget(
                            booking: Booking(
                                userIds: [],
                                hotelId: "hotelId",
                                createdAt: DateTime.now(),
                                startDate: DateTime.now(),
                                endDate: DateTime.now(),
                                description: "description",
                                status: "test",
                                hotelName: "Hotel name",
                                hotelAddress: "Hotel address")),
                      );
                    }, childCount: 5))
                  ],
                );
              }

              if (state is BookingLoaded) {
                if (state.bookings.isEmpty) {
                  return const Center(
                    child: Text('Здесь появятся Ваши бронированния.🏨'),
                  );
                } else {
                  return CustomScrollView(
                      scrollDirection: Axis.vertical,
                      slivers: [
                        SliverList(
                          delegate: SliverChildBuilderDelegate((context, index) {
                            return BookingWidget(booking: state.bookings[index]);
                          },
                          childCount: state.bookings.length
                      )
                    )
                  ]
                );
              }
            }

              if (state is BookingError) {
                return Center(
                  child: Text(state.message),
                );
              }

              return Container();
            })));
  }
}
