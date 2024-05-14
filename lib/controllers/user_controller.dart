import 'package:provider/provider.dart';
import '../models/user.dart';

class UserController extends ChangeNotifierProvider {
  static User? _user;

  UserController({super.key, required super.create});

  static User? getUser() {
    return _user;
  }
  
  static User? setUser(User user) {
    _user = user;
    return _user;
  }
}