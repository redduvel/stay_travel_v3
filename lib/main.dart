import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stay_travel_v3/controllers/features_controller.dart';
import 'package:stay_travel_v3/controllers/hotel_controller.dart';
import 'package:stay_travel_v3/controllers/user_controller.dart';
import 'package:stay_travel_v3/services/local_storage_service.dart';
import 'utils/routes.dart';
import 'views/main/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageService.initialize();
  await LocalStorageService.clear();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HotelController()..fetchHotels()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => FeaturesController()),
      ],
      child: const MyApp()
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    LocalStorageService.initialize();

    return MaterialApp(
      title: 'StayTravel',
      onGenerateRoute: AppRoutes.generateRoute,
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.mainPage,
      home: MainPage(),
    );
  }
}
