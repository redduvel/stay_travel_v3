// Hotels Tab
import 'package:flutter/material.dart';
import 'package:stay_travel_v3/themes/colors.dart';
import 'package:stay_travel_v3/themes/text_styles.dart';
import 'package:stay_travel_v3/utils/static_functions.dart';
import 'package:stay_travel_v3/widgets/hotel_widget.dart';

class HotelsTab extends StatefulWidget {
  const HotelsTab({super.key});

  @override
  State<HotelsTab> createState() => _HotelsTabState();
}

class _HotelsTabState extends State<HotelsTab> {
  final TextEditingController _searchController = TextEditingController();

  Map<String, IconData> hotelFeatures = {
    'Бесплатный Wi-Fi': Icons.wifi,
    'Спа-центр': Icons.spa,
    'Завтрак включен': Icons.egg_alt,
    'Фитнес-центр': Icons.fitness_center,
    'Бассейн': Icons.pool_sharp,
    'Трансфер от/до аэропорта': Icons.airport_shuttle,
    'Парковка': Icons.local_parking,
    'Ресторан и бар': Icons.restaurant,
    'Конференц-залы': Icons.videocam,
    'Допуск с домашними животными': Icons.pets,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Название, адресс или описание отеля...',
            labelText: AppFunctions.getGreetingMessage(),
            labelStyle:
                AppTextStyles.titleTextStyle.copyWith(color: AppColors.grey2),
          ),
          style: AppTextStyles.titleTextStyle,
          cursorColor: AppColors.orange2,
        ),
        automaticallyImplyLeading: false,
        surfaceTintColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                height: 150,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: (hotelFeatures.length / 3.ceil()) * (MediaQuery.sizeOf(context).width * 0.5),
                    child: Row(
                      children: [
                        Expanded(
                          child: Wrap(
                            spacing: 5,
                            children: hotelFeatures.entries.map((entry) {
                                return Chip(
                                  avatar: Icon(entry.value, color: AppColors.black),
                                  label: Text(entry.key),
                                  backgroundColor: AppColors.orange,
                                  side: BorderSide.none,
                                );
                              }).toList(),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: Text(
                'Популярные отели',
                style: AppTextStyles.subheaderBoldStyle,
              ),
            ),
            SliverToBoxAdapter(
                child: Wrap(
              direction: Axis.horizontal,
              spacing: 3,
              runSpacing: 5,
              children: List.generate(
                  5,
                  (index) => HotelWidget()),
            )),
          ],
        ),
      ),
    );
  }
}
