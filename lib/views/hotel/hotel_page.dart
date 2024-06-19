// Hotel Page
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stay_travel_v3/bloc/hotels/hotel/hotel_bloc.dart';
import 'package:stay_travel_v3/bloc/hotels/hotel/hotel_event.dart';
import 'package:stay_travel_v3/bloc/hotels/hotel/hotel_state.dart';
import 'package:stay_travel_v3/models/hotel.dart';
import 'package:stay_travel_v3/services/local_storage_service.dart';
import 'package:stay_travel_v3/themes/text_styles.dart';
import 'package:stay_travel_v3/utils/routes.dart';
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
  late Hotel hotel;

  @override
  void initState() {
    BlocProvider.of<HotelBloc>(context)
        .add(FetchHotel(hotelId: widget.hotelId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height-100,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Детали отеля',
            style: AppTextStyles.subheaderStyle,
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7.5),
          child: BlocListener<HotelBloc, HotelState>(
            listener: (context, state) {
              if (state is HotelError) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.message),
                ));
              }
            },
            child: BlocBuilder<HotelBloc, HotelState>(
              builder: (context, state) {
                if (state is HotelLoading) {
                  return const HotelPageSkeleton();
                }
      
                if (state is HotelLoaded) {
                  hotel = state.hotel;
                  return HotelPageWidget(hotel: state.hotel);
                }
      
                return Container();
              },
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
          child: CustomButton.normal(
            text: 'Посетить',
            mainAxisAlignment: MainAxisAlignment.center,
            onPressed: () {
              if (LocalStorageService.getToken() == null) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Сначала нужно авторизоваться.'),
                ));
                return;
              }
      
              Navigator.pushNamed(context, Routes.bookingPage, arguments: hotel);
            },
          ),
        ),
      ),
    );
  }
}
