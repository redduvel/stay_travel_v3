// Hotels Tab  
import 'package:flutter/material.dart';
import 'package:stay_travel_v3/themes/colors.dart';

class HotelsTab extends StatefulWidget {
  const HotelsTab({super.key});

  @override
  State<HotelsTab> createState() => _HotelsTabState();
}

class _HotelsTabState extends State<HotelsTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          SliverToBoxAdapter(
            child: Text('Отели'),
          ),
          SliverToBoxAdapter(
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder:(context, index) {
              
              return Container(
                width: 100,
                height: 30,
                color: AppColors.grey,
              );
            },)
          ),
          
        ],
      ),
    );
  }
}