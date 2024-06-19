
import 'package:equatable/equatable.dart';

abstract class HotelEvent extends Equatable {
  const HotelEvent();

  @override
  List<Object> get props => [];
}

class FetchHotel extends HotelEvent {
  final String hotelId;

  const FetchHotel({required this.hotelId});

  @override
  List<Object> get props => [hotelId];
}

