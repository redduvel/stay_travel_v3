import 'package:equatable/equatable.dart';
import 'package:stay_travel_v3/models/booking.dart';

abstract class BookingEvent extends Equatable {
  const BookingEvent();

  @override
  List<Object> get props => [];
}

class CreateBooking extends BookingEvent {
  final Booking booking;

  const CreateBooking(this.booking);

  @override
  List<Object> get props => [booking];
}

class UpdateBookingStatus extends BookingEvent {
  final String bookingId;
  final String status;

  const UpdateBookingStatus(this.bookingId, this.status);

  @override
  List<Object> get props => [bookingId, status];
}

class DeleteBooking extends BookingEvent {
  final String bookingId;

  const DeleteBooking(this.bookingId);

  @override
  List<Object> get props => [bookingId];
}

class FetchUserBookings extends BookingEvent {}

class FetchBusinessmanBookings extends BookingEvent {}

