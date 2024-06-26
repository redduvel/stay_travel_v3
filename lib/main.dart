import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:stay_travel_v3/bloc/auth/auth_bloc.dart';
import 'package:stay_travel_v3/bloc/auth/auth_service.dart';
import 'package:stay_travel_v3/bloc/booking/booking_bloc.dart';
import 'package:stay_travel_v3/bloc/booking/booking_service.dart';
import 'package:stay_travel_v3/bloc/hotels/hotel/hotel_bloc.dart';
import 'package:stay_travel_v3/bloc/hotels/hotels_bloc.dart';
import 'package:stay_travel_v3/bloc/hotels/hotels_service.dart';
import 'package:stay_travel_v3/bloc/hotels/user_hotels/user_hotels_bloc.dart';
import 'package:stay_travel_v3/bloc/messages/messages_bloc.dart';
import 'package:stay_travel_v3/bloc/messages/messages_services.dart';
import 'package:stay_travel_v3/bloc/review/review_bloc.dart';
import 'package:stay_travel_v3/bloc/review/review_service.dart';
import 'package:stay_travel_v3/bloc/server/server_bloc.dart';
import 'package:stay_travel_v3/bloc/server/server_service.dart';
import 'package:stay_travel_v3/bloc/user/user_bloc.dart';
import 'package:stay_travel_v3/bloc/user/user_service.dart';
import 'package:stay_travel_v3/controllers/features_controller.dart';
import 'package:stay_travel_v3/services/local_storage_service.dart';
import 'package:stay_travel_v3/views/main/main_page.dart';
import 'utils/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/cupertino.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await LocalStorageService.initialize();

  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ServerBloc>(create: (context) => ServerBloc(ServerService())),
        BlocProvider<AuthBloc>(create: (context) => AuthBloc(AuthService())),
        ChangeNotifierProvider(create: (context) => FeaturesController()),
        BlocProvider<HotelsBloc>(create: (context) => HotelsBloc(HotelService())),
        BlocProvider<BookingBloc>(create: (context) => BookingBloc(BookingService())),
        BlocProvider<UserHotelsBloc>(create: (context) => UserHotelsBloc(HotelService())),
        BlocProvider<UserBloc>(create: (context) => UserBloc(UserService())),
        BlocProvider<MessagesBloc>(create: (context) => MessagesBloc(MessagesServices())),
        BlocProvider<HotelBloc>(create: (context) => HotelBloc(HotelService())),
        BlocProvider<ReviewBloc>(create: (context) => ReviewBloc(ReviewService()))
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
      ],
      locale: Locale('ru', 'RU'),
      title: 'StayTravel',
      onGenerateRoute: AppRoutes.generateRoute,
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.welcomePage,
      home: MainPage(),
    );
  }
}
