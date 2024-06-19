import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stay_travel_v3/bloc/hotels/hotels_service.dart';
import 'package:stay_travel_v3/models/hotel.dart';
import 'package:stay_travel_v3/utils/logger.dart';
import 'hotels_event.dart';
import 'hotels_state.dart';

class HotelsBloc extends Bloc<HotelsEvent, HotelsState> {
  bool isFetchingMore = false;
  List<Hotel> hotels = [];
  final HotelService hotelService;

  HotelsBloc(this.hotelService) : super(HotelsInitial()) {
    on<FetchHotels>(_onFetchHotels);
    on<FetchMoreHotels>(_onFetchMoreHotels);
    on<SearchHotels>(_onSearchHotels);
    on<FilterHotelsByFeature>(_onFilterHotelsByFeature);
    on<FetchFavoriteHotels>(_onFetchFavoriteHotels);
    on<AddHotelToFavorites>(_onAddHotelToFavorites);
    on<RemoveHotelFromFavorites>(_onRemoveHotelFromFavorites);
    on<CreateHotel>(_createHotel);
  }

  // Получение/Поиск/Сортировка отелей
  Future<void> _onFetchHotels(FetchHotels event, Emitter<HotelsState> emit) async {
    emit(HotelsLoading());
    try {
      final hotels = await hotelService.fetchHotels(skip: event.page, limit: event.limit);
      this.hotels = hotels;
      emit(HotelsLoaded(hotels));
    } catch (e) {
      emit(HotelsError(e.toString()));
    }
  }

  Future<void> _onFetchMoreHotels(FetchMoreHotels event, Emitter<HotelsState> emit) async {
    if (state is HotelsLoaded) {
      final loadedState = state as HotelsLoaded;
      if (!isFetchingMore) {
        isFetchingMore = true;
        try {
          final hotels = await hotelService.fetchHotels(skip: event.page, limit: event.limit);
          this.hotels = this.hotels + hotels;
          emit(HotelsLoaded(loadedState.hotels + hotels));
        } catch (e) {
          emit(HotelsError(e.toString()));
        } finally {
          isFetchingMore = false;
        }
      }
    }
  }

  Future<void> _onSearchHotels(SearchHotels event, Emitter<HotelsState> emit) async {
    emit(HotelsLoading());
    try {
      // Implement search logic here using ApiService
      // final hotels = await ApiService.instance.searchHotels(query: event.query);
      // emit(HotelLoaded(hotels));
    } catch (e) {
      emit(HotelsError(e.toString()));
    }
  }

Future<void> _onFilterHotelsByFeature(FilterHotelsByFeature event, Emitter<HotelsState> emit) async {
  if (event.selectedFeatures.isEmpty) {
    emit(HotelsLoaded(hotels)); // Return full list if no filters
    return;
  }

  final List<Hotel> filteredHotels = hotels.where((hotel) {
    final hotelFeatureIds = hotel.features.map((feature) => feature.id).toSet();
    return event.selectedFeatures.every((feature) => hotelFeatureIds.contains(feature.id));
  }).toList();

  filteredHotels.sort((a, b) {
    final aFeatureIds = a.features.map((feature) => feature.id).toSet();
    final bFeatureIds = b.features.map((feature) => feature.id).toSet();
    final aMatchCount = event.selectedFeatures.where((feature) => aFeatureIds.contains(feature.id)).length;
    final bMatchCount = event.selectedFeatures.where((feature) => bFeatureIds.contains(feature.id)).length;
    return bMatchCount.compareTo(aMatchCount); // Sort in descending order of match count
  });

  Logger.log("Filter hotels", level: LogLevel.info);
  emit(HotelsFiltered(filteredHotels));
}


  // Получение/Добавление/Удаление избранных
  Future<void> _onFetchFavoriteHotels(FetchFavoriteHotels event, Emitter<HotelsState> emit) async {
    emit(FavoriteHotelsLoading());
    try {
      final favoriteHotels = await hotelService.fetchFavoriteHotels();

      emit(FavoriteHotelsLoaded(favoriteHotels));
    } catch (e) {
      emit(const FavoriteHotelsError('Неизвестная ошибка.'));
    }
  }

  Future<void> _onAddHotelToFavorites(AddHotelToFavorites event, Emitter<HotelsState> emit) async {
    if (state is HotelsLoaded) {
      final loadedState = state as HotelsLoaded;
      final favoriteHotels = List<Hotel>.from(loadedState.hotels);
      final hotelIndex = favoriteHotels.indexWhere((hotel) => hotel.id == event.hotel.id);
      if (hotelIndex != -1) {
        favoriteHotels[hotelIndex].isFavorite = true;
        await hotelService.addHotelToFavorites(event.hotel.id);
      }
      emit(HotelsLoaded(favoriteHotels));
    }
  }

  Future<void> _onRemoveHotelFromFavorites(RemoveHotelFromFavorites event, Emitter<HotelsState> emit) async {
    if (state is HotelsLoaded) {
      final loadedState = state as HotelsLoaded;
      final favoriteHotels = List<Hotel>.from(loadedState.hotels);
      final hotelIndex = favoriteHotels.indexWhere((hotel) => hotel.id == event.hotel.id);
      if (hotelIndex != -1) {
        favoriteHotels[hotelIndex].isFavorite = false;
        await hotelService.removeHotelFromFavorites(event.hotel.id);
      }
      emit(HotelsLoaded(favoriteHotels));
    }
  }

  // Создание отеля
Future<void> _createHotel(CreateHotel event, Emitter<HotelsState> emit) async {
  emit(CreateHotelLoading());
  try {
    final success = await hotelService.createHotel(
      name: event.hotelData['name'],
      address: event.hotelData['address'],
      description: event.hotelData['description'],
      features: event.hotelData['features'],
      photos: event.hotelData['images'],
    );

    if (success) {
      emit(CreateHotelSuccessful());
    } else {
      emit(const CreateHotelError('Ошибка создания отеля'));
    }
  } catch (e) {
    emit(CreateHotelError(e.toString()));
  }
}

}


