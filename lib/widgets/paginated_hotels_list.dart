import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stay_travel_v3/bloc/hotels/hotels_bloc.dart';
import 'package:stay_travel_v3/bloc/hotels/hotels_state.dart';
import 'package:stay_travel_v3/widgets/hotel_widget.dart';

class PaginatedHotelList extends StatefulWidget {
  final ScrollController scrollController;

  const PaginatedHotelList({super.key, required this.scrollController});

  @override
  _PaginatedHotelListState createState() => _PaginatedHotelListState();
}

class _PaginatedHotelListState extends State<PaginatedHotelList> {
  @override
  void dispose() {
    widget.scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HotelsBloc, HotelsState>(
      builder: (context, state) {
        if (state is HotelsLoading) {
          return CustomScrollView(
            controller: widget.scrollController,
            slivers: const [
              SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              ),
            ],
          );
        } else if (state is HotelsLoaded) {
          return CustomScrollView(
            controller: widget.scrollController,
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return HotelWidget(hotel: state.hotels[index]);
                  },
                  childCount: state.hotels.length,
                ),
              ),
            ],
          );
        } else if (state is HotelsError) {
          return CustomScrollView(
            controller: widget.scrollController,
            slivers: const [
              SliverFillRemaining(
                child: Center(child: Text('Ошибка загрузки')),
              ),
            ],
          );
        } else {
          return CustomScrollView(
            controller: widget.scrollController,
            slivers: const [
              SliverFillRemaining(
                child: Center(child: Text('Нет доступных отелей')),
              ),
            ],
          );
        }
      },
    );
  }
}
