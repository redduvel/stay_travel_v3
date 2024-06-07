import 'package:flutter/material.dart';
import 'package:stay_travel_v3/models/hotel.dart';
import 'package:stay_travel_v3/themes/colors.dart';
import 'package:stay_travel_v3/views/main_for_bussines/create_hotel_page.dart';
import 'package:stay_travel_v3/widgets/hotel_widget.dart';

class HotelsPageBussines extends StatefulWidget {
  const HotelsPageBussines({super.key});

  @override
  State<HotelsPageBussines> createState() => _HotelsPageBussinesState();
}

class _HotelsPageBussinesState extends State<HotelsPageBussines> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Ваши отели'),
      ),
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          SliverList(delegate: SliverChildBuilderDelegate(
            (context, index) {
              return HotelWidget(hotel: Hotel(id: "id", name: "name", description: "description", address: "address", averageRating: null, images: [],  createdAt: DateTime.now(), features: []));
            },
            childCount: 5
          ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.orange,
        foregroundColor: AppColors.background,
        child: const Icon(Icons.add, size: 32,),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder:(context) => CreateHotelPage(),));
        }),
    );
  }
}