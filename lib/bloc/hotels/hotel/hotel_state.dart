
import 'package:equatable/equatable.dart';
import 'package:stay_travel_v3/models/hotel.dart';

abstract class HotelState extends Equatable {
  const HotelState();

  @override
  List<Object> get props => [];
}

class HotelInitial extends HotelState {}

class HotelLoading extends HotelState {}

class HotelLoaded extends HotelState {
  final Hotel hotel;

  const HotelLoaded(this.hotel);
}

class HotelError extends HotelState {
  final String message;

  const HotelError(this.message);

  @override
  List<Object> get props => [message];
}