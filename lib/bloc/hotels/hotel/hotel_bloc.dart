import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stay_travel_v3/bloc/hotels/hotel/hotel_event.dart';
import 'package:stay_travel_v3/bloc/hotels/hotel/hotel_state.dart';
import 'package:stay_travel_v3/bloc/hotels/hotels_service.dart';


class HotelBloc extends Bloc<HotelEvent, HotelState> {
  bool isFetchingMore = false;
  final HotelService hotelService;

  HotelBloc(this.hotelService) : super(HotelInitial()) {
    on<FetchHotel>(_fetchHotel);
  }

    // Получение опредленного отеля
  Future<void> _fetchHotel(FetchHotel event, Emitter<HotelState> emit) async {
    emit(HotelLoading());
    try {
      final hotel = await hotelService.fetchHotelById(event.hotelId);
      if (hotel == null) {
        emit(const HotelError('Ошибка получения отеля.'));
      } else {
        emit(HotelLoaded(hotel));
      }
    } catch (e) {
      emit(HotelError(e.toString()));
    }
  }
}