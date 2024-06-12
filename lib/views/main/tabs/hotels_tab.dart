import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:stay_travel_v3/bloc/hotels/hotels_bloc.dart';
import 'package:stay_travel_v3/bloc/hotels/hotels_event.dart';
import 'package:stay_travel_v3/bloc/hotels/hotels_state.dart';
import 'package:stay_travel_v3/models/hotel.dart';
import 'package:stay_travel_v3/themes/colors.dart';
import 'package:stay_travel_v3/themes/text_styles.dart';
import 'package:stay_travel_v3/utils/fake_data.dart';
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
  final int limit = 5;
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<HotelsBloc>().add(FetchHotels(page: 1, limit: limit));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      setState(() {
        isLoadingMore = true;
      });
      context.read<HotelsBloc>().add(FetchMoreHotels(page: ++currentPage, limit: limit));
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
            labelStyle: AppTextStyles.titleTextStyle.copyWith(color: AppColors.grey2),
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
            child: HotelFeaturesList(height: 100, width: 1000,),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: BlocBuilder<HotelsBloc, HotelsState>(
          builder: (context, state) {
            if (state is HotelsLoading) {
              return _buildLoadingState();
            } else if (state is HotelsError) {
              return _buildErrorState();
            } else if (state is HotelsLoaded) {
              return _buildLoadedState(state.hotels);
            } else {
              return _buildEmptyState();
            }
          },
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    final List<Hotel> fakeHotels = List.filled(5, FakeData.fakeHotel);
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: Skeletonizer(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 7.5),
              child: Text(
                'Популярные отели',
                style: AppTextStyles.subheaderBoldStyle,
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => Skeletonizer(
              child: HotelWidget(hotel: fakeHotels[index]),
            ),
            childCount: fakeHotels.length,
          ),
        ),
      ],
    );
  }

  Widget _buildErrorState() {
    return const Center(child: Text('Ошибка загрузки отелей'));
  }

  Widget _buildLoadedState(List<Hotel> hotels) {
    return RefreshIndicator(
      onRefresh: () async {
        currentPage = 1;
        context.read<HotelsBloc>().add(FetchHotels(page: currentPage, limit: limit));
      },
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(7.5),
              child: Text(
                'Популярные отели',
                style: AppTextStyles.subheaderBoldStyle,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => HotelWidget(hotel: hotels[index]),
              childCount: hotels.length,
            ),
          ),
          if (isLoadingMore)
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
                    createdAt: DateTime.now(),
                    features: [],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return RefreshIndicator(
      onRefresh: () async {
        currentPage = 1;
        context.read<HotelsBloc>().add(FetchHotels(page: currentPage, limit: limit));
      },
      child: const CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Center(child: Text('Нет доступных отелей.')),
          ),
        ],
      ),
    );
  }
}
