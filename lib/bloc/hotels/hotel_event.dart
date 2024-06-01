import 'package:equatable/equatable.dart';
import 'package:stay_travel_v3/models/feature.dart';

abstract class HotelEvent extends Equatable {
  const HotelEvent();

  @override
  List<Object?> get props => [];
}

class FetchHotels extends HotelEvent {
  final int page;
  final int limit;

  const FetchHotels({required this.page, required this.limit});

  @override
  List<Object?> get props => [page, limit];
}

class SearchHotels extends HotelEvent {
  final String query;

  const SearchHotels(this.query);

  @override
  List<Object?> get props => [query];
}

class FilterHotelsByFeature extends HotelEvent {
  final List<Feature> selectedFeatures;

  const FilterHotelsByFeature(this.selectedFeatures);

  @override
  List<Object?> get props => [selectedFeatures];
}

class FetchMoreHotels extends HotelEvent {
  final int page;
  final int limit;

  const FetchMoreHotels({required this.page, required this.limit});

  @override
  List<Object?> get props => [page, limit];
}


