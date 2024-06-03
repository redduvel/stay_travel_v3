import 'package:stay_travel_v3/models/booking.dart';
import 'package:stay_travel_v3/services/api_service.dart';
import 'package:stay_travel_v3/utils/logger.dart';

class BookingService {
  Future<String?> createBooking(Booking booking) async {
    try {
      final response = await ApiService.instance.dio.post(
        '/bookings/',
        data: booking.toJson(),
        options: ApiService.instance.getHeaders(),
      );
      return response.data['id'];
    } catch (e) {
      Logger.log('$e', level: LogLevel.error);
      return null;
    }
  }

  Future<bool> updateBookingStatus(String bookingId, String status) async {
    try {
      await ApiService.instance.dio.put(
        '/bookings/$bookingId/status',
        data: {'status': status},
        options: ApiService.instance.getHeaders(),
      );
      return true;
    } catch (e) {
      Logger.log('$e', level: LogLevel.error);
      return false;
    }
  }

  Future<List<Booking>> fetchUserBookings() async {
    try {
      final response = await ApiService.instance.dio.get(
        '/bookings/user',
        options: ApiService.instance.getHeaders(),
      );
      return List<Booking>.from(
          response.data.map((booking) => Booking.fromJson(booking)));
    } catch (e) {
      Logger.log('$e', level: LogLevel.error);
      return [];
    }
  }

  Future<bool> deleteBooking(String bookingId) async {
    try {
      await ApiService.instance.dio.delete(
        '/bookings/$bookingId',
        options: ApiService.instance.getHeaders(),
      );
      return true;
    } catch (e) {
      Logger.log('$e', level: LogLevel.error);
      return false;
    }
  }
}
