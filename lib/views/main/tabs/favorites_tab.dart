// Favorites Tab
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:stay_travel_v3/bloc/hotels/hotels_bloc.dart';
import 'package:stay_travel_v3/bloc/hotels/hotels_event.dart';
import 'package:stay_travel_v3/bloc/hotels/hotels_state.dart';
import 'package:stay_travel_v3/models/hotel.dart';
import 'package:stay_travel_v3/themes/text_styles.dart';
import 'package:stay_travel_v3/utils/fake_data.dart';
import 'package:stay_travel_v3/widgets/hotel_widget.dart';

class FavoritesTab extends StatefulWidget {
  const FavoritesTab({super.key});

  @override
  State<FavoritesTab> createState() => _FavoritesTabState();
}

class _FavoritesTabState extends State<FavoritesTab> {

  @override
  void initState() {
    if ((context.read<HotelsBloc>().state is FavoriteHotelsLoaded) == false) {
      BlocProvider.of<HotelsBloc>(context).add(FetchFavoriteHotels());
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Избранные отели'),
          automaticallyImplyLeading: false,
          surfaceTintColor: Colors.white,
          actions: [
            IconButton(onPressed: () {
              context.read<HotelsBloc>().add(FetchFavoriteHotels());
            }, icon: const Icon(Icons.history))
          ]
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: BlocListener<HotelsBloc, HotelsState>(
            listener: (context, state) {
              if (state is FavoriteHotelsError) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.message),
                ));
              }
            },
            child:
                BlocBuilder<HotelsBloc, HotelsState>(builder: (context, state) {
              if (state is FavoriteHotelsLoading) {
                return CustomScrollView(
                  scrollDirection: Axis.vertical,
                  slivers: [
                    const SliverToBoxAdapter(
                      child: Skeletonizer(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 7.5),
                          child: Text(
                            'Избранные отели',
                            style: AppTextStyles.subheaderBoldStyle,
                          ),
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final List<Hotel> fakeHotels =
                            List.filled(5, FakeData.fakeHotel);

                        return Skeletonizer(
                            child: HotelWidget(
                          hotel: fakeHotels[index],
                        ));
                      }),
                    )
                  ],
                );
              }

              if (state is FavoriteHotelsLoaded) {
                if (state.favoriteHotels.isEmpty) {
                  return const Center(
                    child: Text('Тут появяться отели, которые Вы отметили.'),
                  );
                } else {
                  return RefreshIndicator(
                    onRefresh: () async {
                      BlocProvider.of<HotelsBloc>(context).add(FetchFavoriteHotels());
                    },
                    child: CustomScrollView(
                      scrollDirection: Axis.vertical,
                      slivers: [
                        const SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7.5),
                            child: Text(
                              'Избранные отели',
                              style: AppTextStyles.subheaderBoldStyle,
                            ),
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              Hotel hotel = state.favoriteHotels[index];
                              hotel.isFavorite = true;
                              return HotelWidget(hotel: hotel);
                            },
                            childCount: state.favoriteHotels.length,
                          ),
                        ),
                      ],
                    ),
                  );
                }
              }

              return Container();
            }),
          ),
        ));
  }
}
