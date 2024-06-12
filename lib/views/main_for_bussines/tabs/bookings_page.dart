import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:stay_travel_v3/bloc/booking/booking_bloc.dart';
import 'package:stay_travel_v3/bloc/booking/booking_event.dart';
import 'package:stay_travel_v3/bloc/booking/booking_state.dart';
import 'package:stay_travel_v3/models/booking.dart';
import 'package:stay_travel_v3/widgets/user_booking_widget.dart';

class BookingsPageBussines extends StatefulWidget {
  const BookingsPageBussines({super.key});

  @override
  State<BookingsPageBussines> createState() => _BookingsPageBussinesState();
}

class _BookingsPageBussinesState extends State<BookingsPageBussines> {
  @override
  void initState() {
    context.read<BookingBloc>().add(FetchBusinessmanBookings());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Заявки на бронирование'),
        actions: [
          IconButton(
              onPressed: () {
                context.read<BookingBloc>().add(FetchBusinessmanBookings());
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
              context.read<BookingBloc>().add(FetchBusinessmanBookings());

        },
        child: BlocBuilder<BookingBloc, BookingState>(
          builder: (context, state) {
            if (state is BookingLoading) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomScrollView(
                  scrollDirection: Axis.vertical,
                  slivers: [
                    SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                      return Skeletonizer(
                          child: BookingRequestWidget(
                        booking: Booking(
                            userIds: ["userIds"],
                            hotelId: "hotelId",
                            createdAt: DateTime.now(),
                            startDate: DateTime.now(),
                            endDate: DateTime.now(),
                            description: "description",
                            status: "status"),
                      ));
                    }, childCount: 5))
                  ],
                ),
              );
            }
        
            if (state is BookingLoaded) {
              if (state.bookings.isEmpty) {
                return const Center(
                  child: Text('Здесь появятся заявки Ваших клиентов.'),
                );
              }
        
              List<Booking> sortedBookings = List.from(state.bookings);
              sortedBookings.sort((a, b) {
                if (a.status == 'waiting' && b.status != 'waiting') {
                  return -1;
                } else if (a.status != 'waiting' && b.status == 'waiting') {
                  return 1;
                } else if (a.status == 'active' && b.status != 'active') {
                  return -1;
                } else if (a.status != 'active' && b.status == 'active') {
                  return 1;
                } else {
                  return 0;
                }
              });
        
              return Padding(
                padding: const EdgeInsets.all(8),
                child: CustomScrollView(
                  scrollDirection: Axis.vertical,
                  slivers: [
                    SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return BookingRequestWidget(
                            booking: sortedBookings[index]);
                      }, childCount: sortedBookings.length),
                    ),
                  ],
                ),
              );
            }
        
            return Container();
          },
        ),
      ),
    );
  }
}
