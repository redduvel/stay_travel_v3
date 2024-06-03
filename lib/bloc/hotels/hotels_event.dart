import 'package:equatable/equatable.dart';
import 'package:stay_travel_v3/models/feature.dart';
import 'package:stay_travel_v3/models/hotel.dart';

abstract class HotelsEvent extends Equatable {
  const HotelsEvent();

  @override
  List<Object?> get props => [];
}

// События для списка отелей
class FetchHotels extends HotelsEvent {
  final int page;
  final int limit;

  const FetchHotels({required this.page, required this.limit});

  @override
  List<Object?> get props => [page, limit];
}

class SearchHotels extends HotelsEvent {
  final String query;

  const SearchHotels(this.query);

  @override
  List<Object?> get props => [query];
}

class FilterHotelsByFeature extends HotelsEvent {
  final List<Feature> selectedFeatures;

  const FilterHotelsByFeature(this.selectedFeatures);

  @override
  List<Object?> get props => [selectedFeatures];
}

class FetchMoreHotels extends HotelsEvent {
  final int page;
  final int limit;

  const FetchMoreHotels({required this.page, required this.limit});

  @override
  List<Object?> get props => [page, limit];
}

// События для добавления/удаления/получения избранных
class FetchFavoriteHotels extends HotelsEvent {}

class AddHotelToFavorites extends HotelsEvent {
  final Hotel hotel;

  const AddHotelToFavorites(this.hotel);
}

class RemoveHotelFromFavorites extends HotelsEvent {
  final Hotel hotel;

  const RemoveHotelFromFavorites(this.hotel);
}

// События для определенного отеля
class FetchHotel extends HotelsEvent {
  final String hotelId;

  const FetchHotel({required this.hotelId});

  @override
  List<Object?> get props => [hotelId];
}
