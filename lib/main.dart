import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:stay_travel_v3/bloc/auth/auth_bloc.dart';
import 'package:stay_travel_v3/bloc/auth/auth_service.dart';
import 'package:stay_travel_v3/bloc/booking/booking_bloc.dart';
import 'package:stay_travel_v3/bloc/booking/booking_service.dart';
import 'package:stay_travel_v3/bloc/hotels/hotels_bloc.dart';
import 'package:stay_travel_v3/bloc/hotels/hotels_service.dart';
import 'package:stay_travel_v3/controllers/features_controller.dart';
import 'package:stay_travel_v3/services/local_storage_service.dart';
import 'package:stay_travel_v3/views/main/main_page.dart';
import 'utils/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/cupertino.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageService.initialize();

  runApp(
    MultiBlocProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FeaturesController()),
        BlocProvider<AuthBloc>(create: (context) => AuthBloc(AuthService())),
        BlocProvider<HotelsBloc>(create: (context) => HotelsBloc(HotelService())),
        BlocProvider<BookingBloc>(create: (context) => BookingBloc(BookingService()))
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
      ],
      locale: const Locale('ru', 'RU'),
      title: 'StayTravel',
      onGenerateRoute: AppRoutes.generateRoute,
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.mainPage,
      home: MainPage(),
    );
  }
}
