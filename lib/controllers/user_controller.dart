import 'package:stay_travel_v3/services/api_service.dart';
import 'package:stay_travel_v3/services/local_storage_service.dart';
import '../models/user.dart';

import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  Future<void> login(String emailOrNumber, String password) async {
    _user = await ApiService.instance.login(emailOrNumber, password);
    notifyListeners();
  }

  Future<void> register(Map<String, dynamic> userData) async {
    _user = await ApiService.instance.register(userData);
    notifyListeners();
  }

  void logout() {
    _user = null;
    LocalStorageService.saveToken('');
    notifyListeners();
  }
}


