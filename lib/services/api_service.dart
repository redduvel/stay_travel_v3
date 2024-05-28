import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import '../models/feature.dart';
import '../models/user.dart';
import '../models/hotel.dart';
import '../models/review.dart';
import '../models/booking.dart';
import '../utils/logger.dart';

import 'local_storage_service.dart'; // Импортируем LocalStorageService

class ApiService {
  static ApiService? _instance;
  static bool serverAviable = false;

  static ApiService get instance {
    _instance ??= ApiService._internal();
    return _instance!;
  }

  ApiService._internal();

  Dio dio = Dio(
    BaseOptions(
      baseUrl: Uri.parse('https://set-chicken-purely.ngrok-free.app').toString(),
    ),
  );
  

  // Получение заголовков с токеном
  Options _getHeaders() {
    String? token = LocalStorageService.getToken();
    return Options(
      headers: {
        'Authorization': token != null ? 'Bearer $token' : '',
      },
    );
  }

  // Проверка состояния сервера
  Future<void> pingServer() async {
    try {
      final response = await dio.get('/ping');
      serverAviable = true;
      Logger.log(response.data, level: LogLevel.debug);
    } catch (e) {
      Logger.log('$e', level: LogLevel.error);
    }
  }

  // Аутентификация пользователя
  Future<User?> login(String emailOrNumber, String password) async {
    try {
      final response = await dio.post(
        '/auth/login',
        data: {'emailOrNumber': emailOrNumber, 'password': password},
      );
      // Сохранение токена
      if (response.data['token'] != null) {
        await LocalStorageService.saveToken(response.data['token']);
      }
      
      User user = User.fromJson(response.data);

      return user;
    } catch (e) {
      Logger.log('$e', level: LogLevel.error);
      return null;
    }
  }

  // Регистрация пользователя
  Future<User?> register(Map<String, dynamic> userData) async {
    try {
      final response = await dio.post('/auth/register', data: userData);
      // Сохранение токена
      if (response.data['token'] != null) {
        await LocalStorageService.saveToken(response.data['token']);
      }

      User user = User.fromJson(response.data['user']);
      
      return user;
    } catch (e) {
      Logger.log('$e', level: LogLevel.error);
      return null;
    }
  }

  // Получение списка отелей
  Future<List<Hotel>> fetchHotels({int skip = 0, int limit = 10}) async {
    try {
      (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
        client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
        return client;
      };


      final response = await dio.get('/hotels', queryParameters: {'page': skip, 'limit': limit});
      
      return List<Hotel>.from(
          response.data['hotels'].map((hotel) => Hotel.fromJson(hotel)));
    } catch (e) {
      Logger.log('$e', level: LogLevel.error);
      return [];
    }
  }

  // Получение конкретного отеля
  Future<Hotel?> fetchHotelById(String hotelId) async {
    try {
      final response = await dio.get('/hotels/$hotelId');
      return Hotel.fromJson(response.data);
    } catch (e) {
      Logger.log('$e', level: LogLevel.error);
      return null;
    }
  }

  // Создание бронирования
  Future<String?> createBooking(Booking booking) async {
    try {
      final response = await dio.post(
        '/bookings/',
        data: booking.toJson(),
        options: _getHeaders(), // Использование заголовков с токеном
      );
      return response.data['id'];
    } catch (e) {
      Logger.log('$e', level: LogLevel.error);
      return null;
    }
  }

  // Изменение статуса бронирования
  Future<bool> updateBookingStatus(String bookingId, String status) async {
    try {
      await dio.put(
        '/bookings/$bookingId/status',
        data: {'status': status},
        options: _getHeaders(), // Использование заголовков с токеном
      );
      return true;
    } catch (e) {
      Logger.log('$e', level: LogLevel.error);
      return false;
    }
  }

  // Получение бронирований пользователя
  Future<List<Booking>> fetchUserBookings() async {
    try {
      final response = await dio.get(
        '/bookings/user',
        options: _getHeaders(), // Использование заголовков с токеном
      );
      return List<Booking>.from(
          response.data.map((booking) => Booking.fromJson(booking)));
    } catch (e) {
      Logger.log('$e', level: LogLevel.error);
      return [];
    }
  }

  // Создание отзыва
  Future<bool> createReview(Review review, String hotelId) async {
    try {
      await dio.post(
        '/reviews/hotel/$hotelId',
        data: review.toJson(),
        options: _getHeaders(), // Использование заголовков с токеном
      );
      return true;
    } catch (e) {
      Logger.log('$e', level: LogLevel.error);
      return false;
    }
  }

  // Получение отзывов отеля
  Future<List<Review>> fetchHotelReviews(String hotelId) async {
    try {
      final response = await dio.get('/reviews/hotel/$hotelId');
      return List<Review>.from(
          response.data.map((review) => Review.fromJson(review)));
    } catch (e) {
      Logger.log('$e', level: LogLevel.error);
      return [];
    }
  }

  // Обновление данных пользователя
  Future<bool> updateUserSettings(User user) async {
    try {
      await dio.put(
        '/settings/update',
        data: user.toJson(),
        options: _getHeaders(), // Использование заголовков с токеном
      );
      return true;
    } catch (e) {
      Logger.log('$e', level: LogLevel.error);
      return false;
    }
  }

  // Обновление пароля пользователя
  Future<bool> updatePassword(
      String currentPassword, String newPassword) async {
    try {
      await dio.put(
        '/settings/update_password',
        data: {'currentPassword': currentPassword, 'newPassword': newPassword},
        options: _getHeaders(), // Использование заголовков с токеном
      );
      return true;
    } catch (e) {
      Logger.log('$e', level: LogLevel.error);
      return false;
    }
  }

  // получение особенностей отеля
  Future<List<Feature>> fetchFeatures() async {
    try {
      (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
        client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
        return client;
      };


      final response = await dio.get('/features/');

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => Feature.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load features');
      } 
    } catch (e) {
      Logger.log('$e', level: LogLevel.error);
      return [];
    }
  }
}
