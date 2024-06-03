// Main Page  
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stay_travel_v3/bloc/auth/auth_bloc.dart';
import 'package:stay_travel_v3/bloc/auth/auth_event.dart';
import 'package:stay_travel_v3/bloc/auth/auth_state.dart';
import 'package:stay_travel_v3/services/local_storage_service.dart';
import 'package:stay_travel_v3/themes/colors.dart';
import 'package:stay_travel_v3/themes/text_styles.dart';
import 'package:stay_travel_v3/utils/routes.dart';
import 'tabs/bookings_tab.dart';
import 'tabs/favorites_tab.dart';
import 'tabs/hotels_tab.dart';
import 'tabs/notifications_tab.dart';
import 'tabs/profile_tab.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 2;
  final List<Widget> _children = [
    const BookingsTab(),
    const FavoritesTab(),
    const HotelsTab(),
    const NotificationsTab(),
    const ProfileTab()
  ];

  void onTabTapped(int index) {
    if (index == 4 && LocalStorageService.getToken() == null) {
      Navigator.pushNamed(context, Routes.startPage);
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (context.read<AuthBloc>().state is AuthAuthenticated) {
      return;
    } else {
      context.read<AuthBloc>().add(CheckAuthEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

    return ScaffoldMessenger(
      key: scaffoldMessengerKey,
      child: Scaffold(
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {

            scaffoldMessengerKey.currentState?.clearSnackBars(); // Очистка существующих SnackBars
            if (state is AuthLoading) {
              scaffoldMessengerKey.currentState?.showSnackBar(const SnackBar(
                content: Text('Проверка сохраненной сессии...'),
              ));
            }
            if (state is AuthAuthenticated) {
              scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
                content: Text('С возвращением, ${state.user.firstname}!'),
              ));
            }
            if (state is AuthError) {
              scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
                content: Text(state.message),
              ));
            }
          },
          child: _children[_currentIndex]
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedLabelStyle: AppTextStyles.bodyTextStyle,
          unselectedLabelStyle: AppTextStyles.bodyTextStyle,
          selectedItemColor: AppColors.orange2,
          unselectedItemColor: AppColors.grey2,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'Бронирования',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Избранное',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.hotel),
              label: 'Отели',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Уведомления',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Профиль',
            ),
          ],
        ),
      ),
    );
  }
}
