import 'package:flutter/material.dart';
import 'package:stay_travel_v3/services/local_storage_service.dart';
import 'package:stay_travel_v3/themes/colors.dart';
import 'package:stay_travel_v3/themes/text_styles.dart';
import 'package:stay_travel_v3/utils/routes.dart';
import 'package:stay_travel_v3/views/main/tabs/profile_tab.dart';
import 'package:stay_travel_v3/views/main_for_bussines/tabs/bookings_page.dart';
import 'package:stay_travel_v3/views/main_for_bussines/tabs/hotels_page.dart';

class MainPageForBussines extends StatefulWidget {
  const MainPageForBussines({super.key});

  @override
  State<MainPageForBussines> createState() => _MainPageForBussinesState();
}

class _MainPageForBussinesState extends State<MainPageForBussines> {
  int _currentIndex = 1;
  final List<Widget> _children = [
    const HotelsPageBussines(),
    const BookingsPageBussines(),
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
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
              icon: Icon(Icons.hotel),
              label: 'Мои отели',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'Бронирования',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Профиль',
            ),
          ],
        ),
    );
  }
}