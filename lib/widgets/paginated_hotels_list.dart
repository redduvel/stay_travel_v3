import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:stay_travel_v3/controllers/hotel_controller.dart';
import 'package:stay_travel_v3/models/feature.dart';
import 'package:stay_travel_v3/models/hotel.dart';
import 'package:stay_travel_v3/widgets/hotel_widget.dart';

class PaginatedHotelList extends StatefulWidget {
  const PaginatedHotelList({Key? key}) : super(key: key);

  @override
  _PaginatedHotelListState createState() => _PaginatedHotelListState();
}

class _PaginatedHotelListState extends State<PaginatedHotelList> {
  late ScrollController _scrollController;
  late HotelController _hotelController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _hotelController = HotelController();
    _hotelController.fetchHotels();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent &&
          _hotelController.hasMore &&
          !_hotelController.isLoading) {
        _hotelController.fetchHotels();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HotelController>(
      create: (_) => _hotelController,
      child: Consumer<HotelController>(
        builder: (context, controller, child) { 
          if (controller.isLoading && controller.hotels.isEmpty) {
            Skeletonizer(
              child: HotelWidget(hotel: controller.fakeHotel),
            );
          }

          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                if (index == controller.hotels.length) {
                  return Skeletonizer(child: HotelWidget(hotel: controller.fakeHotel));
                }
                final hotel = controller.hotels[index];
                  return HotelWidget(hotel: hotel);
                },
              childCount: controller.hotels.length + (controller.hasMore ? 1 : 0),
            ),
          );
        },
      ),
    );
  }
}
