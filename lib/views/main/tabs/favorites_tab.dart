// Favorites Tab  
import 'package:flutter/material.dart';
import 'package:stay_travel_v3/themes/colors.dart';
import 'package:stay_travel_v3/themes/text_styles.dart';

class FavoritesTab extends StatefulWidget {
  const FavoritesTab({super.key});

  @override
  State<FavoritesTab> createState() => _FavoritesTabState();
}

class _FavoritesTabState extends State<FavoritesTab> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Название, адресс или описание отеля...',
            labelText: 'Поиск в избранных',
            labelStyle: AppTextStyles.titleTextStyle.copyWith(color: AppColors.grey2),
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
                      borderRadius: BorderRadius.all(Radius.circular(12))
                    ), 
                  )
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}