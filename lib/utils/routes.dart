import 'package:flutter/material.dart';
import 'package:stay_travel_v3/models/hotel.dart';
import 'package:stay_travel_v3/views/auth/login_page.dart';
import 'package:stay_travel_v3/views/auth/registration_page.dart';
import 'package:stay_travel_v3/views/booking/create_booking_page.dart';
import 'package:stay_travel_v3/views/hotel/hotel_page.dart';
import 'package:stay_travel_v3/views/main/main_page.dart';
import 'package:stay_travel_v3/views/main_for_bussines/main_page.dart';
import 'package:stay_travel_v3/views/profile/profile_settings_page.dart';
import 'package:stay_travel_v3/views/start_page.dart';
import 'package:stay_travel_v3/views/welcome_page.dart';

class Routes {
  static const welcomePage = '/welcome';
  static const startPage = '/start';
  static const loginPage = '/login';
  static const registrationPage = '/register';
  static const mainPage = '/main';
  static const hotelPage = '/hotel';
  static const bookingPage = '/booking';
  static const reviewPage = '/review';
  static const profilePage = '/profile';
  static const settingsPage = '/settings';
  static const mainPageBusinessMan = '/mainBusinessman';
  static const profileSettingsPage = '/profileSettings';
}
class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.welcomePage:
        return MaterialPageRoute(builder: (context) {
          return const WelcomePage();
        });
      case Routes.startPage:
        return MaterialPageRoute(builder: (context) {
          return const StartPage();
        });
      case Routes.loginPage:
        return MaterialPageRoute(builder: (context) {
          return const LoginPage();
        });
      case Routes.registrationPage:
        return MaterialPageRoute(builder: (context) {
          return const RegistrationPage();
        });
      case Routes.hotelPage:
        return MaterialPageRoute(builder: (context) {
          final hotelId = settings.arguments as String;
          return HotelPage(hotelId: hotelId);
        });
      case Routes.mainPage:
        return MaterialPageRoute(builder: (context) {
          return const MainPage();
        });
      case Routes.bookingPage:
        return MaterialPageRoute(builder: (context) {
          final hotel = settings.arguments as Hotel;
          return CreateBookingPage(hotel: hotel);
        });
      case Routes.mainPageBusinessMan:
        return MaterialPageRoute(builder: (context) {
          return const MainPageForBussines();
        });
      case Routes.profileSettingsPage:
        return MaterialPageRoute(builder: (context) {
          return const ProfileSettingsPage();
        });
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text("Маршрут недоступен"),
            ),
          ),
        );
    }
  }
}