import 'package:dio/dio.dart';
import 'package:stay_travel_v3/utils/logger.dart';
import 'local_storage_service.dart';

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
      baseUrl: 'https://stay-travel-v3-api.onrender.com',
    ),
  );

  // Getting headers with token
  Options getHeaders() {
    String? token = LocalStorageService.getToken();

    return Options(
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token != null ? 'Bearer $token' : '',
      },
    );
  }
}
