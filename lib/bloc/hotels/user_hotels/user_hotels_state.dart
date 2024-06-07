import 'package:equatable/equatable.dart';
import 'package:stay_travel_v3/models/hotel.dart';

abstract class UserHotelsState extends Equatable {
  const UserHotelsState();

  @override
  List<Object?> get props => [];
}


// Состояния для списка отелей
class UserHotelsInitial extends UserHotelsState {}

class UserHotelsLoading extends UserHotelsState {}

class UserHotelsLoaded extends UserHotelsState {
  final List<Hotel> hotels;

  const UserHotelsLoaded(this.hotels);
}

class UserHotelsError extends UserHotelsState {
  final String message;

  const UserHotelsError(this.message);

  @override
  List<Object?> get props => [message];
}
