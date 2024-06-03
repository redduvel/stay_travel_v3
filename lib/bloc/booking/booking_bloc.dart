import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stay_travel_v3/bloc/booking/booking_event.dart';
import 'package:stay_travel_v3/bloc/booking/booking_service.dart';
import 'package:stay_travel_v3/bloc/booking/booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final BookingService bookingService;

  BookingBloc(this.bookingService) : super(BookingInitial()) {
    on<CreateBooking>(_onCreateBooking);
    on<UpdateBookingStatus>(_onUpdateBookingStatus);
    on<DeleteBooking>(_onDeleteBooking);
    on<FetchUserBookings>(_onFetchUserBookings);
  }

  Future<void> _onCreateBooking(CreateBooking event, Emitter<BookingState> emit) async {
    emit(BookingLoading());
    try {
      final bookingId = await bookingService.createBooking(event.booking);
      if (bookingId != null) {
        emit(BookingCreated());
      } else {
        emit(const BookingError('Ошибка создания бронирования'));
      }
    } catch (e) {
      emit(BookingError(e.toString()));
    }
  }

  Future<void> _onUpdateBookingStatus(UpdateBookingStatus event, Emitter<BookingState> emit) async {
    emit(BookingLoading());
    try {
      final success = await bookingService.updateBookingStatus(event.bookingId, event.status);
      if (success) {
        emit(BookingUpdated());
      } else {
        emit(const BookingError('Ошибка обновления статуса'));
      }
    } catch (e) {
      emit(BookingError(e.toString()));
    }
  }

  Future<void> _onDeleteBooking(DeleteBooking event, Emitter<BookingState> emit) async {
    emit(BookingLoading());
    try {
      final success = await bookingService.deleteBooking(event.bookingId);  // Добавьте метод deleteBooking в BookingService
      if (success) {
        emit(BookingDeleted());
      } else {
        emit(const BookingError('Failed to delete booking'));
      }
    } catch (e) {
      emit(BookingError(e.toString()));
    }
  }

  Future<void> _onFetchUserBookings(FetchUserBookings event, Emitter<BookingState> emit) async {
    emit(BookingLoading());
    try {
      final bookings = await bookingService.fetchUserBookings();
      emit(BookingLoaded(bookings));
    } catch (e) {
      emit(BookingError(e.toString()));
    }
  }
}
