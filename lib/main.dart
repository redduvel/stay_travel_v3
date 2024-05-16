import 'package:flutter/material.dart';
import 'package:stay_travel_v3/themes/theme.dart';
import 'utils/routes.dart';
import 'views/welcome_page.dart';
import 'views/start_page.dart';
import 'views/auth/login_page.dart';
import 'views/auth/registration_page.dart';
import 'views/main/main_page.dart';
import 'views/hotel/hotel_page.dart';
import 'views/booking/create_booking_page.dart';
import 'views/hotel/review_page.dart';
import 'views/profile/profile_details_page.dart';
import 'views/profile/profile_settings_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: Routes.mainPage,
      routes: {
        Routes.welcomePage: (context) => const WelcomePage(),
        Routes.startPage: (context) => const StartPage(),
        Routes.loginPage: (context) => const LoginPage(),
        Routes.registrationPage: (context) => const RegistrationPage(),
        Routes.mainPage: (context) => MainPage(),
        Routes.hotelPage: (context) => const HotelPage(),
        Routes.bookingPage: (context) => const CreateBookingPage(),
        Routes.reviewPage: (context) => const ReviewPage(),
        Routes.profilePage: (context) => const ProfileDetailsPage(),
        Routes.settingsPage: (context) => const ProfileSettingsPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}