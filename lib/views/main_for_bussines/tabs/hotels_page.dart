import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:stay_travel_v3/bloc/hotels/user_hotels/user_hotels_bloc.dart';
import 'package:stay_travel_v3/bloc/hotels/user_hotels/user_hotels_event.dart';
import 'package:stay_travel_v3/bloc/hotels/user_hotels/user_hotels_state.dart';
import 'package:stay_travel_v3/themes/colors.dart';
import 'package:stay_travel_v3/utils/fake_data.dart';
import 'package:stay_travel_v3/views/main_for_bussines/create_hotel_page.dart';
import 'package:stay_travel_v3/widgets/user_hotel_widget.dart';

class HotelsPageBussines extends StatefulWidget {
  const HotelsPageBussines({super.key});

  @override
  State<HotelsPageBussines> createState() => _HotelsPageBussinesState();
}

class _HotelsPageBussinesState extends State<HotelsPageBussines> {

  @override
  void initState() {
    context.read<UserHotelsBloc>().add(const FetchUserHotels());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Ваши отели'),
        actions: [
          IconButton(onPressed: () async {
            context.read<UserHotelsBloc>().add(const FetchUserHotels());
          }, icon: Icon(Icons.refresh),)
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
              context.read<UserHotelsBloc>().add(const FetchUserHotels());
        },
        child: BlocBuilder<UserHotelsBloc, UserHotelsState>(
          builder: (context, state) {
            if (state is UserHotelsLoading) {
              return Skeletonizer(
                child: CustomScrollView(
                scrollDirection: Axis.vertical,
                slivers: [
                  SliverList(delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return UserHotelWidget(hotel: FakeData.fakeHotel);
                    },
                    childCount: 5
                  ))
                ],
              )
              );
            }
        
            if (state is UserHotelsLoaded) {
              if (state.hotels.isEmpty) {
                return const Center(child: Text(
                  'Здесь появятся Ваши отели.'
                ),);
              }
        
              return CustomScrollView(
                scrollDirection: Axis.vertical,
                slivers: [
                  SliverList(delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return UserHotelWidget(hotel: state.hotels[index]);
                    },
                    childCount: state.hotels.length
                  ))
                ],
              );
            }
        
            return SizedBox.shrink();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.orange,
        foregroundColor: AppColors.background,
        child: const Icon(Icons.add, size: 32,),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder:(context) => const CreateHotelPage(),));
        }),
    );
  }
}