import 'package:stay_travel_v3/models/user.dart';
import 'package:stay_travel_v3/services/api_service.dart';
import 'package:stay_travel_v3/utils/logger.dart';

class UserService {
  Future<bool> updateUserSettings(User user) async {
    try {
      await ApiService.instance.dio.put(
        '/settings/update',
        data: user.toJson(),
        options: ApiService.instance.getHeaders(),
      );
      return true;
    } catch (e) {
      Logger.log('$e', level: LogLevel.error);
      return false;
    }
  }

  Future<bool> updatePassword(String currentPassword, String newPassword) async {
    try {
      final response = await ApiService.instance.dio.put(
        '/settings/update_password',
        data: {'old_password': currentPassword, 'new_password': newPassword},
        options: ApiService.instance.getHeaders(),
      );

      if (response.statusCode == 200) {
        return true;
      }else {
        return false;
      }
    } catch (e) {
      Logger.log('$e', level: LogLevel.error);
      return false;
    }
  }
}
