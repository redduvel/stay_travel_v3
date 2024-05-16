// Hotels Tab
import 'package:flutter/material.dart';
import 'package:stay_travel_v3/themes/colors.dart';
import 'package:stay_travel_v3/themes/text_styles.dart';
import 'package:stay_travel_v3/utils/static_functions.dart';

class HotelsTab extends StatefulWidget {
  const HotelsTab({super.key});

  @override
  State<HotelsTab> createState() => _HotelsTabState();
}

class _HotelsTabState extends State<HotelsTab> {
  final TextEditingController _searchController = TextEditingController();

  List<String> hotelFeatures = [
    'Бесплатный Wi-Fi',
    'Спа-центр',
    'Завтрак включен',
    'Фитнес-центр',
    'Бассейн',
    'Трансфер от/до аэропорта',
    'Парковка',
    'Ресторан и бар',
    'Конференц-залы',
    'Допуск с домашними животными',
  ];

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
                            children: List.generate(
                              hotelFeatures.length,
                              (index) => Chip(
                                label: Text(hotelFeatures[index]),
                                backgroundColor: AppColors.grey,
                                shape: null,
                              ),
                            ),
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
                  (index) => Container(
                        width: double.infinity,
                        height: 150,
                        decoration: const BoxDecoration(
                            color: AppColors.grey3,
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                      )),
            )),
          ],
        ),
      ),
    );
  }
}
