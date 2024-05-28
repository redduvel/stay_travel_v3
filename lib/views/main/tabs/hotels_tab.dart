// Hotels Tab
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:stay_travel_v3/controllers/hotel_controller.dart';
import 'package:stay_travel_v3/themes/colors.dart';
import 'package:stay_travel_v3/themes/text_styles.dart';
import 'package:stay_travel_v3/utils/static_functions.dart';
import 'package:stay_travel_v3/widgets/hotel_features.dart';
import 'package:stay_travel_v3/widgets/hotel_list_widget.dart';
import 'package:stay_travel_v3/widgets/paginated_hotels_list.dart';

class HotelsTab extends StatefulWidget {
  const HotelsTab({super.key});

  @override
  State<HotelsTab> createState() => _HotelsTabState();
}

class _HotelsTabState extends State<HotelsTab> {
  final TextEditingController _searchController = TextEditingController();

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
        child:  CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: [
            const SliverToBoxAdapter(child: HotelFeaturesList()),
            SliverToBoxAdapter(
              child: Consumer<HotelController>(
                builder: (context, value, child) {
                  return Skeletonizer(
                    enabled: value.isLoading,
                    child: const Text(
                      'Популярные отели',
                      style: AppTextStyles.subheaderBoldStyle,
                    ),
                  );
                },
              ),
            ),
            const PaginatedHotelList()
          ],
        ),
      ),
    );
  }
}
