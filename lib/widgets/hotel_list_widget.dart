import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:stay_travel_v3/controllers/hotel_controller.dart';
import 'package:stay_travel_v3/models/feature.dart';
import 'package:stay_travel_v3/models/hotel.dart';
import 'package:stay_travel_v3/widgets/custom_button.dart';
import 'hotel_widget.dart';

class HotelsListScreen extends StatelessWidget {
  List<Hotel> fakeHotels = List.filled(
    5, 
    Hotel(
      id: "id", 
      name: "Hotel name Hotel name", 
      description: "This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.", 
      address: "Hotel address, Hotel address", 
      averageRating: 5, 
      images: [], 
      reviews: [], 
      createdAt: DateTime.now(),
      features: [
        Feature(id: "id", name: "name", icon: "wi-fi"),
        Feature(id: "id", name: "name", icon: "wi-fi"),
        Feature(id: "id", name: "name", icon: "wi-fi"),
        Feature(id: "id", name: "name", icon: "wi-fi"),
        Feature(id: "id", name: "name", icon: "wi-fi"),
        Feature(id: "id", name: "name", icon: "wi-fi"),
        Feature(id: "id", name: "name", icon: "wi-fi"),
        Feature(id: "id", name: "name", icon: "wi-fi")
      ]
    )
  );

  HotelsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HotelController>(
      builder: (context, hotelController, child) {
        if (hotelController.isLoading && hotelController.hotels.isEmpty) {
          return Wrap(
            direction: Axis.horizontal,
            spacing: 3,
            runSpacing: 5,
            children: List.generate(
              fakeHotels.length,
              (index) => Skeletonizer(
                child: HotelWidget(
                  hotel: fakeHotels[index]
                )
              )
            ),
          );
        } else if (hotelController.hotels.isNotEmpty) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                fit: FlexFit.loose,
                child: Wrap(
                  direction: Axis.horizontal,
                  spacing: 3,
                  runSpacing: 5,
                  children: List.generate(
                    hotelController.hotels.length,
                    (index) => HotelWidget(
                      hotel: hotelController.hotels[index]
                    )
                  )
                )
              ),
              if (hotelController.hasMore)
                CustomButton.normal(
                  text: "Загрузить больше",
                  onPressed: () {
                    hotelController.fetchHotels(
                      //skip: hotelController.hotels.length,
                      //limit: 10
                    );
                  }
                )
            ]
          );
        } else {
          return Center(
            child: Column(
              children: [
                Text('Ошибка загрузки отелей'),
                CustomButton.normal(
                  text: "Повторить попытку",
                  onPressed: () {
                    hotelController.retryFetch();
                  }
                )
              ],
            ),
          );
        }
      }
    );
  }
}
