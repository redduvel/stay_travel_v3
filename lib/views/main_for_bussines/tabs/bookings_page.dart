import 'package:flutter/material.dart';
import 'package:stay_travel_v3/themes/colors.dart';

class BookingsPageBussines extends StatefulWidget {
  const BookingsPageBussines({super.key});

  @override
  State<BookingsPageBussines> createState() => _BookingsPageBussinesState();
}

class _BookingsPageBussinesState extends State<BookingsPageBussines> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Заявки на бронирование'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.refresh))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Card(
                child: Row(
                  children: [
                    Container(
                      width: 20,
                      height: 120, 
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                        ),
                        color: AppColors.orange
                      ),
                    ),
                    const Column(
                      children: [
                        Text('Title'),
                        Text('Address'),
                        Text('scsdcsdc'),
                        Text('dsvsdv')
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      
    );
    
  }
}