import 'package:equatable/equatable.dart';
import 'package:stay_travel_v3/bloc/hotels/hotels_service.dart';
import 'package:stay_travel_v3/models/hotel.dart';

abstract class HotelsState extends Equatable {
  const HotelsState();

  @override
  List<Object?> get props => [];
}


// Состояния для списка отелей
class HotelsInitial extends HotelsState {}

class HotelsLoading extends HotelsState {}

class HotelsLoaded extends HotelsState {
  final List<Hotel> hotels;

  const HotelsLoaded(this.hotels);
}

class HotelsError extends HotelsState {
  final String message;

  const HotelsError(this.message);

  @override
  List<Object?> get props => [message];
}

class HotelsFiltered extends HotelsState {
  final List<Hotel> hotels;

  const HotelsFiltered(this.hotels);

  @override
  List<Object?> get props => [hotels];
}


// Состояния для добавления/удаления/получения избранных
class FavoriteHotelsLoading extends HotelsState {}

class FavoriteHotelsLoaded extends HotelsState {
  final List<Hotel> favoriteHotels;

  const FavoriteHotelsLoaded(this.favoriteHotels);
}

class FavoriteHotelsError extends HotelsState {
  final String message;

  const FavoriteHotelsError(this.message);
}


// Состояния для получения определенного отеля
class HotelInitial extends HotelsState {}

class HotelLoading extends HotelsState {}

class HotelLoaded extends HotelsState {
  final Hotel hotel;

  const HotelLoaded(this.hotel);
}

class HotelError extends HotelsState {
  final String message;

  const HotelError(this.message);

  @override
  List<Object?> get props => [message];
}

class CreateHotelLoading extends HotelsState {}

class CreateHotelSuccessful extends HotelsState {}

class CreateHotelError extends HotelsState {
  final String message;

  const CreateHotelError(this.message);

  @override
  List<Object?> get props => [message];
}
