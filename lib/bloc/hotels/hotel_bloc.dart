import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stay_travel_v3/models/hotel.dart';
import 'package:stay_travel_v3/services/api_service.dart';
import 'hotel_event.dart';
import 'hotel_state.dart';

class HotelBloc extends Bloc<HotelEvent, HotelState> {
  bool isFetchingMore = false;

  HotelBloc() : super(HotelInitial()) {
    on<FetchHotels>(_onFetchHotels);
    on<FetchMoreHotels>(_onFetchMoreHotels);
    on<SearchHotels>(_onSearchHotels);
    on<FilterHotelsByFeature>(_onFilterHotelsByFeature);
  }

  Future<void> _onFetchHotels(FetchHotels event, Emitter<HotelState> emit) async {
    emit(HotelLoading());
    try {
      final hotels = await ApiService.instance.fetchHotels(skip: event.page, limit: event.limit);
      emit(HotelLoaded(hotels));
    } catch (e) {
      emit(HotelError(e.toString()));
    }
  }

  Future<void> _onFetchMoreHotels(FetchMoreHotels event, Emitter<HotelState> emit) async {
    if (state is HotelLoaded) {
      final loadedState = state as HotelLoaded;
      if (!isFetchingMore) {
        isFetchingMore = true;
        try {
          final hotels = await ApiService.instance.fetchHotels(skip: event.page, limit: event.limit);
          emit(HotelLoaded(loadedState.hotels + hotels));
        } catch (e) {
          emit(HotelError(e.toString()));
        } finally {
          isFetchingMore = false;
        }
      }
    }
  }

  Future<void> _onSearchHotels(SearchHotels event, Emitter<HotelState> emit) async {
    emit(HotelLoading());
    try {
      // Implement search logic here using ApiService
      //final hotels = await ApiService.instance.searchHotels(query: event.query);
      //emit(HotelLoaded(hotels));
    } catch (e) {
      emit(HotelError(e.toString()));
    }
  }

  Future<void> _onFilterHotelsByFeature(FilterHotelsByFeature event, Emitter<HotelState> emit) async {
    if (state is HotelLoaded) {
      final loadedState = state as HotelLoaded;

      if (event.selectedFeatures.isEmpty) {
        emit(HotelLoaded(loadedState.hotels)); // Возвращаем полный список, если фильтры отсутствуют
        return;
      }

      final List<Hotel> filteredHotels = loadedState.hotels.where((hotel) {
        final hotelFeatureIds = hotel.features.map((feature) => feature.id).toSet();
        return event.selectedFeatures.every((feature) => hotelFeatureIds.contains(feature.id));
      }).toList();

      emit(HotelLoaded(filteredHotels));
    }
  }
}