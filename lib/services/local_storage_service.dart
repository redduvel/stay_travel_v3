import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static SharedPreferences? _preferences;

  static Future initialize() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // Сохранение значения по ключу
  static Future<bool> setValue(String key, dynamic value) async {
    if (value is bool) {
      return await _preferences!.setBool(key, value);
    } else if (value is int) {
      return await _preferences!.setInt(key, value);
    } else if (value is double) {
      return await _preferences!.setDouble(key, value);
    } else if (value is String) {
      return await _preferences!.setString(key, value);
    } else if (value is List<String>) {
      return await _preferences!.setStringList(key, value);
    }
    return false;
  }

  // Получение значения по ключу
  static dynamic getValue(String key) {
    return _preferences!.get(key);
  }

  // Удаление значения по ключу
  static Future<bool> removeValue(String key) {
    return _preferences!.remove(key);
  }

  // Сохранение токена
  static Future<bool> saveToken(String token) {
    return setValue('auth_token', token);
  }

  // Получение токена
  static String? getToken() {
    return _preferences!.getString('auth_token');
  }

  // Очистка всех данных из хранилища
  static Future<bool> clear() {
    return _preferences!.clear();
  }
}
