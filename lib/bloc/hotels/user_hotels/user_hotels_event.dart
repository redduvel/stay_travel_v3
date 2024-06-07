import 'package:equatable/equatable.dart';

abstract class UserHotelsEvent extends Equatable {
  const UserHotelsEvent();

  @override
  List<Object?> get props => [];
}

// События для списка отелей
class FetchUserHotels extends UserHotelsEvent {
  const FetchUserHotels();

  @override
  List<Object?> get props => [];
}

