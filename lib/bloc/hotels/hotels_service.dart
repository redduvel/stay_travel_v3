import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:stay_travel_v3/models/hotel.dart';
import 'package:stay_travel_v3/services/api_service.dart';
import 'package:stay_travel_v3/services/local_storage_service.dart';
import 'package:stay_travel_v3/utils/logger.dart';

class HotelService {
  Future<List<Hotel>> fetchHotels({int skip = 0, int limit = 10}) async {
    try {
      final response = await ApiService.instance.dio
          .get('/hotels', queryParameters: {'page': skip, 'limit': limit});

      switch (response.statusCode) {
        case 200:
          final hotels = List<Hotel>.from(
              response.data['hotels'].map((hotel) => Hotel.fromJson(hotel)));
          return hotels;
        case 404:
          Logger.log("Hotels not found");
          return [];
      }

      return [];
    } catch (e) {
      Logger.log('$e', level: LogLevel.error);
      return [];
    }
  }

  Future<Hotel?> fetchHotelById(String hotelId) async {
    try {
      final response = await ApiService.instance.dio.get('/hotels/$hotelId');
      return Hotel.fromJson(response.data);
    } catch (e) {
      Logger.log('$e', level: LogLevel.error);
      return null;
    }
  }

  Future<List<Hotel>> searchHotels(String query) async {
    final response = await ApiService.instance.dio.get('/hotels/search?query=$query');

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.data);
      return jsonData.map((hotel) => Hotel.fromJson(hotel)).toList();
    } else {
      throw Exception('Failed to search hotels');
    }
  }

  Future<List<Hotel>> fetchFavoriteHotels() async {
    try {
      final response = await ApiService.instance.dio.get(
        '/favorites/',
        options: ApiService.instance.getHeaders(),
      );

      if (response.statusCode == 200) {
        return List<Hotel>.from(response.data.map((hotel) => Hotel.fromJson(hotel)));
      } else {
        _handleStatusCode(response.statusCode!);
        return [];
      }
    } on DioException catch (e) {
      _handleDioError(e);
      return [];
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<void> addHotelToFavorites(String hotelId) async {
    try {
      final response = await ApiService.instance.dio.post(
        '/favorites/add/$hotelId',
        options: ApiService.instance.getHeaders(),
      );

      if (response.statusCode != 200) {
        _handleStatusCode(response.statusCode!);
      }
    } on DioException catch (e) {
      _handleDioError(e);
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<void> removeHotelFromFavorites(String hotelId) async {
    try {
      final response = await ApiService.instance.dio.delete(
        '/favorites/remove/$hotelId',
        options: ApiService.instance.getHeaders(),
      );

      if (response.statusCode != 200) {
        _handleStatusCode(response.statusCode!);
      }
    } on DioException catch (e) {
      _handleDioError(e);
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<bool> createHotel({
    required String name,
    required String address,
    required String description,
    required List<String> features,
    required List<String> photos,
  }) async {
    try {
      // Convert images to base64
      List<String> base64Photos = photos.map((path) {
        File file = File(path);
        return base64Encode(file.readAsBytesSync());
      }).toList();

      // Prepare JSON data
      Map<String, dynamic> data = {
        'name': name,
        'address': address,
        'description': description,
        'features': features,
        'photos': base64Photos,
      };

      Response response = await ApiService.instance.dio.post(
        '/hotels/',
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            // Include authorization header if needed
            'Authorization': 'Bearer ${LocalStorageService.getToken()}',
          },
        ),
      );

      if (response.statusCode == 201) {
        print('Hotel created successfully');
        return true;
      } else {
        print('Failed to create hotel');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  void _handleStatusCode(int statusCode) {
    switch (statusCode) {
      case 400:
        throw Exception('Bad request');
      case 401:
        throw Exception('Unauthorized');
      case 403:
        throw Exception('Forbidden');
      case 404:
        throw Exception('Not found');
      case 500:
        throw Exception('Internal server error');
      default:
        throw Exception('Unexpected error: $statusCode');
    }
  }

  void _handleDioError(DioException error) {
    if (error.type == DioExceptionType.connectionTimeout) {
      throw Exception('Connection timeout');
    } else if (error.type == DioExceptionType.sendTimeout) {
      throw Exception('Send timeout');
    } else if (error.type == DioExceptionType.receiveTimeout) {
      throw Exception('Receive timeout');
    } else if (error.type == DioExceptionType.badResponse) {
      _handleStatusCode(error.response?.statusCode ?? 500);
    } else if (error.type == DioExceptionType.cancel) {
      throw Exception('Request canceled');
    } else {
      throw Exception('Unexpected error: ${error.message}');
    }
  }
}
