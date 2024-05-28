import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:stay_travel_v3/controllers/features_controller.dart';
import 'package:stay_travel_v3/models/feature.dart';
import 'package:stay_travel_v3/services/api_service.dart';
import 'package:stay_travel_v3/themes/colors.dart';

class HotelFeaturesList extends StatefulWidget {
  const HotelFeaturesList({super.key});

  @override
  State<HotelFeaturesList> createState() => _HotelFeaturesListState();
}

class _HotelFeaturesListState extends State<HotelFeaturesList> {
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
    return ChangeNotifierProvider(
      create: (_) => Provider.of<FeaturesController>(context, listen: false),
      child: SizedBox(
        height: 150,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: (hotelFeatures.length / 3.ceil()) *
                (MediaQuery.sizeOf(context).width * 0.5),
            child: Row(
              children: [
                Expanded(
                  child: FutureBuilder<List<Feature>>(
                    future: ApiService.instance.fetchFeatures(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Wrap(
                          spacing: 5,
                          children: hotelFeatures.entries.map((entry) {
                            return Skeletonizer(
                              child: Chip(
                                avatar: Icon(entry.value, color: AppColors.black),
                                label: Text(entry.key),
                                backgroundColor: AppColors.grey,
                                side: BorderSide.none,
                              ),
                            );
                          }).toList(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            'Error: ${snapshot.error}'
                          )
                        );
                      } else if (snapshot.hasData) {
                        final features = snapshot.data!;
                        return Consumer<FeaturesController>(
                          builder: (context, provider, child) {
                            // Разделяем выбранные и невыбранные функции
                            final selectedFeatures = features.where((feature) => provider.isSelected(feature.name)).toList();
                            final unselectedFeatures = features.where((feature) => !provider.isSelected(feature.name)).toList();
                            
                            return Wrap(
                              spacing: 5,
                              children: [
                                // Отображаем сначала выбранные функции
                                ...selectedFeatures.map((feature) {
                                  return GestureDetector(
                                    onTap: () {
                                      provider.toggleFeature(feature.name);
                                    },
                                    child: Chip(
                                      avatar: Icon(
                                        feature.iconData,
                                        color: Colors.white,
                                      ),
                                      label: Text(
                                        feature.name,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      backgroundColor: AppColors.orange,
                                      side: BorderSide.none,
                                    ),
                                  );
                                }),
                                // Затем отображаем невыбранные функции
                                ...unselectedFeatures.map((feature) {
                                  return GestureDetector(
                                    onTap: () {
                                      provider.toggleFeature(feature.name);
                                    },
                                    child: Chip(
                                      avatar: Icon(
                                        feature.iconData,
                                        color: AppColors.black,
                                      ),
                                      label: Text(
                                        feature.name,
                                        style: const TextStyle(
                                          color: AppColors.black,
                                        ),
                                      ),
                                      backgroundColor: AppColors.grey,
                                      side: BorderSide.none,
                                    ),
                                  );
                                }),
                              ],
                            );
                          },
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
