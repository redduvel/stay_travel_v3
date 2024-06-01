import 'package:equatable/equatable.dart';
import 'package:stay_travel_v3/models/hotel.dart';

abstract class HotelState extends Equatable {
  const HotelState();

  @override
  List<Object?> get props => [];
}

class HotelInitial extends HotelState {}

class HotelLoading extends HotelState {}

class HotelLoaded extends HotelState {
  final List<Hotel> hotels;

  const HotelLoaded(this.hotels);

  @override
  List<Object?> get props => [hotels];
}

class HotelError extends HotelState {
  final String message;

  const HotelError(this.message);

  @override
  List<Object?> get props => [message];
}

class HotelFiltered extends HotelState {
  final List<Hotel> hotels;

  const HotelFiltered(this.hotels);

  @override
  List<Object?> get props => [hotels];
}
