import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stay_travel_v3/bloc/hotels/hotels_service.dart';
import 'package:stay_travel_v3/bloc/hotels/user_hotels/user_hotels_event.dart';
import 'package:stay_travel_v3/bloc/hotels/user_hotels/user_hotels_state.dart';


class UserHotelsBloc extends Bloc<UserHotelsEvent, UserHotelsState> {
  final HotelService hotelService;

  UserHotelsBloc(this.hotelService) : super(UserHotelsInitial()) {
    on<FetchUserHotels>(_onFetchHotels);
  }

  // Получение/Поиск/Сортировка отелей
  Future<void> _onFetchHotels(FetchUserHotels event, Emitter<UserHotelsState> emit) async {
    emit(UserHotelsLoading());
    try {
      final hotels = await hotelService.fetchUserHotels();
      emit(UserHotelsLoaded(hotels));
    } catch (e) {
      emit(UserHotelsError(e.toString()));
    }
  }

}


