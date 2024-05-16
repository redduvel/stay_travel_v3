// Bookings Tab
import 'package:flutter/material.dart';
import 'package:stay_travel_v3/themes/colors.dart';

class BookingsTab extends StatefulWidget {
  const BookingsTab({super.key});

  @override
  State<BookingsTab> createState() => _BookingsTabState();
}

class _BookingsTabState extends State<BookingsTab> {

  List<String> bookingStatuses = [
    'Активные',
    'В ожидании',
    'Неодобренные',
    'Завершенные'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ваши бронирования'),
        automaticallyImplyLeading: false,
        surfaceTintColor: Colors.white,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.history))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                height: 150,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: (bookingStatuses.length / 3.ceil()) * (MediaQuery.sizeOf(context).width * 0.5),
                    child: Row(
                      children: [
                        Expanded(
                          child: Wrap(
                            spacing: 5,
                            children: List.generate(
                              bookingStatuses.length,
                              (index) => Chip(
                                label: Text(bookingStatuses[index]),
                                backgroundColor: AppColors.grey,
                                shape: null,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Wrap(
                direction: Axis.horizontal,
                spacing: 3,
                runSpacing: 5,
                children: List.generate(
                  5, 
                  (index) => Container(
                    width: double.infinity, 
                    height: 150, 
                    decoration: const BoxDecoration(
                      color: AppColors.grey3,
                      borderRadius: BorderRadius.all(Radius.circular(12))
                    ), 
                  )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
