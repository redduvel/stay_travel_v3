import 'package:dio/dio.dart';
import '../utils/logger.dart';
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
      baseUrl: Uri.parse('https://set-chicken-purely.ngrok-free.app').toString(),
    ),
  );

  // Getting headers with token
  Options getHeaders() {
    String? token = LocalStorageService.getToken();

    return Options(
      headers: {
        'Authorization': token != null ? 'Bearer $token' : '',
      },
    );
  }

  // Server status check
  Future<void> pingServer() async {
    try {
      final response = await dio.get('/ping');
      serverAviable = true;
      Logger.log(response.data, level: LogLevel.debug);
    } catch (e) {
      Logger.log('$e', level: LogLevel.error);
    }
  }
}
