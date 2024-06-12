import 'package:dio/dio.dart';
import 'package:stay_travel_v3/models/user.dart';
import 'package:stay_travel_v3/services/api_service.dart';
import 'package:stay_travel_v3/services/local_storage_service.dart';
import 'package:stay_travel_v3/utils/logger.dart';


class AuthService {
  Future<User?> me(String token) async {
    try {
      final response = await ApiService.instance.dio.get(
        '/auth/me',
        options: ApiService.instance.getHeaders()
      );

      if (response.statusCode == 200) {
        return User.fromJson(response.data);
      } else if (response.statusCode == 400) {
        throw Exception('Ваша сессия устарела. Авторизуйтесь снова.');
      } else if (response.statusCode == 404) {
        throw Exception('Ваша сессия устарела. Авторизуйтесь снова.');
      } else {
        throw Exception('Ошибка сервера.');
      }
    } catch (e) {
      throw Exception('Неизвестная ошибка.');
    }
  }

  Future<User?> login(String emailOrNumber, String password) async {
    try {
      final response = await ApiService.instance.dio.post(
        '/auth/login',
        data: {'emailOrNumber': emailOrNumber, 'password': password},
      );

      // Save token
      if (response.data['token'] != null) {
        await LocalStorageService.saveToken(response.data['token']);
      }

      User user = User.fromJson(response.data);

      return user;
    } on DioException catch (e) {
      if (e.response != null &&
          (e.response?.statusCode == 400 || e.response?.statusCode == 401)) {
        Logger.log('Authorization error: ${e.response?.data}', level: LogLevel.error);
        throw 'Authorization error: ${e.response?.data['error'] ?? 'Unknown error.'}';
      } else {
        Logger.log('Network error: $e', level: LogLevel.error);
        throw 'Network error.';
      }
    } catch (e) {
      Logger.log('Unknown error: $e', level: LogLevel.error);
      throw 'Unknown error.';
    }
  }

  Future<User?> register(Map<String, dynamic> userData) async {
    try {
      final response = await ApiService.instance.dio.post('/auth/register', data: userData);

      if (response.data['token'] != null) {
        await LocalStorageService.saveToken(response.data['token']);

        Logger.log("Save token: ${response.data['token']}", level: LogLevel.info);
      }

      User user = User.fromJson(response.data);

      return user;
    } on DioException catch (e) {
      if (e.response != null &&
          (e.response?.statusCode == 400 || e.response?.statusCode == 401)) {
        Logger.log('Registration error: ${e.response?.data}', level: LogLevel.error);
        throw Exception('Registration error: ${e.response?.data['message'] ?? 'Unknown error'}');
      } else {
        Logger.log('Network error: $e', level: LogLevel.error);
        throw Exception('Network error: $e');
      }
    } catch (e) {
      Logger.log('Unknown error: $e', level: LogLevel.error);
      throw Exception('Unknown error: $e');
    }
  }


}
