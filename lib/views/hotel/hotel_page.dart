// Hotel Page
import 'package:flutter/material.dart';
import 'package:stay_travel_v3/models/hotel.dart';
import 'package:stay_travel_v3/services/api_service.dart';
import 'package:stay_travel_v3/themes/text_styles.dart';
import 'package:stay_travel_v3/utils/logger.dart';
import 'package:stay_travel_v3/views/hotel/widgets/hotel_page_skeleton.dart';
import 'package:stay_travel_v3/views/hotel/widgets/hotel_page_widget.dart';
import 'package:stay_travel_v3/widgets/custom_button.dart';

class HotelPage extends StatefulWidget {
  final String hotelId;
  const HotelPage({super.key, required this.hotelId});

  @override
  State<HotelPage> createState() => _HotelPageState();
}

class _HotelPageState extends State<HotelPage> {
  Hotel? hotel;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchHotel(widget.hotelId);
  }

  Future<Hotel?> fetchHotel(String hotelId) async {
    try {
      hotel = await ApiService.instance.fetchHotelById(hotelId);
      return hotel;
    } catch (e) {
      Logger.log(e.toString(), level: LogLevel.error);
    } finally {
      isLoading = false;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Детали отеля',
          style: AppTextStyles.subheaderStyle,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: FutureBuilder<Hotel?>(
            future: fetchHotel(widget.hotelId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return HotelPageSkeleton(isLoading: isLoading);
              } else if (snapshot.hasError || !snapshot.hasData) {
                return const Center(
                    child: Text('Упс... кажется ошибка на сервере'));
              } else {
                final hotel = snapshot.data!;
                return HotelPageWidget(hotel: hotel);
              }
            }),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
        child: CustomButton.normal(
          text: 'Посетить',
          mainAxisAlignment: MainAxisAlignment.center,
          onPressed: () {},
        ),
      ),
    );
  }
}
