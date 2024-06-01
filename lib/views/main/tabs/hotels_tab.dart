// Hotels Tab
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:stay_travel_v3/bloc/hotels/hotel_bloc.dart';
import 'package:stay_travel_v3/bloc/hotels/hotel_event.dart';
import 'package:stay_travel_v3/bloc/hotels/hotel_state.dart';
import 'package:stay_travel_v3/models/hotel.dart';
import 'package:stay_travel_v3/themes/colors.dart';
import 'package:stay_travel_v3/themes/text_styles.dart';
import 'package:stay_travel_v3/utils/static_functions.dart';
import 'package:stay_travel_v3/widgets/hotel_features.dart';
import 'package:stay_travel_v3/widgets/hotel_widget.dart';

class HotelsTab extends StatefulWidget {
  const HotelsTab({super.key});

  @override
  State<HotelsTab> createState() => _HotelsTabState();
}

class _HotelsTabState extends State<HotelsTab> {
  final TextEditingController _searchController = TextEditingController();
  late ScrollController _scrollController;
  int currentPage = 1;
  final int limit = 10;
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    BlocProvider.of<HotelBloc>(context)
        .add(FetchHotels(page: currentPage, limit: limit)); // Добавлено
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      setState(() {
        isLoadingMore = true;
      });
      BlocProvider.of<HotelBloc>(context)
          .add(FetchMoreHotels(page: ++currentPage, limit: limit));
    }
  }

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
        bottom: const PreferredSize(
            preferredSize: Size(double.infinity, 100),
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: HotelFeaturesList())),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<HotelBloc, HotelState>(
            builder: (context, state) {
              if (state is HotelLoading) {
                return CustomScrollView(
                  scrollDirection: Axis.vertical,
                  slivers: [
                    const SliverToBoxAdapter(
                      child: Skeletonizer(
                        child: Text(
                          'Популярные отели',
                          style: AppTextStyles.subheaderBoldStyle,
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Skeletonizer(
                          child: HotelWidget(
                              hotel: Hotel(
                                  id: "id",
                                  name: "name",
                                  description: "description",
                                  address: "address",
                                  averageRating: null,
                                  images: [],
                                  reviews: [],
                                  createdAt: DateTime.now(),
                                  features: []))),
                    )
                  ],
                );
              } else if (state is HotelError) {
                return const Center(child: Text('Ошибка загрузки отелей'));
              } else if (state is HotelLoaded) {
                return CustomScrollView(
                  scrollDirection: Axis.vertical,
                  controller: _scrollController,
                  slivers: [
                    const SliverToBoxAdapter(
                      child: Text(
                        'Популярные отели',
                        style: AppTextStyles.subheaderBoldStyle,
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return HotelWidget(hotel: state.hotels[index]);
                        },
                        childCount: state.hotels.length,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: isLoadingMore
                          ? Skeletonizer(
                              child: HotelWidget(
                                  hotel: Hotel(
                                      id: "id",
                                      name: "name",
                                      description: "description",
                                      address: "address",
                                      averageRating: null,
                                      images: [],
                                      reviews: [],
                                      createdAt: DateTime.now(),
                                      features: [])))
                          : const SizedBox.shrink(),
                    ),
                  ],
                );
              } else {
                return const Center(child: Text('Нет доступных отелей.'));
              }
            },
          )),
    );
  }
}
