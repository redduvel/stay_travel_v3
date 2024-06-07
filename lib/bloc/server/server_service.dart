import 'package:stay_travel_v3/services/api_service.dart';
import 'package:stay_travel_v3/utils/logger.dart';

class ServerService {
    // Server status check
  Future<bool> pingServer() async {
    try {
      final response = await ApiService.instance.dio.get('/ping');
      Logger.log(response.data['message'], level: LogLevel.debug);
      if (response.data['status'] == "ok") {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      Logger.log('$e', level: LogLevel.error);
      return false;
    }
  }
}