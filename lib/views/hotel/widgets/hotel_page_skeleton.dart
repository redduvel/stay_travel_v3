import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:stay_travel_v3/models/hotel.dart';
import 'package:stay_travel_v3/utils/fake_data.dart';

class HotelPageSkeleton extends StatefulWidget {
  const HotelPageSkeleton({super.key});

  @override
  State<HotelPageSkeleton> createState() => _HotelPageSkeletonState();
}

class _HotelPageSkeletonState extends State<HotelPageSkeleton> {
  Hotel hotel = FakeData.fakeHotel;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: Image.network(
                  'https://mykaleidoscope.ru/x/uploads/posts/2022-09/1663154968_6-mykaleidoscope-ru-p-buenos-aires-argentina-krasivo-6.jpg'),
            ),
          ),
           SliverToBoxAdapter(
            child: Text(
              hotel.name,
              textAlign: TextAlign.center,
            ),
          ),
           SliverToBoxAdapter(
            child: Text(
              hotel.address,
              textAlign: TextAlign.center,
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 5)
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Card(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    width: double.infinity,
                    child: Text(hotel.description)
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Card(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        width: 150,
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('4.5'),
                            Text('rating')
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        width: 200,
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('8.6K'),
                            Text('people rated')
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 5),
                Card(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    width: double.infinity,
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('2.3K'),
                        Text('people saved')
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Card(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    width: double.infinity,
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.abc),
                            Icon(Icons.abc),
                            Icon(Icons.abc),
                            Icon(Icons.abc),
                          ],
                        ),
                        Text('hotel features')
                      ],
                    ),
                  ),
                ),
              ],
            )
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Фотографии', textAlign: TextAlign.left,),
                SizedBox(
                  height: 400,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    children: [
                      Image.network('https://mykaleidoscope.ru/x/uploads/posts/2022-09/1663154968_6-mykaleidoscope-ru-p-buenos-aires-argentina-krasivo-6.jpg'),
                      Image.network('https://mykaleidoscope.ru/x/uploads/posts/2022-09/1663154968_6-mykaleidoscope-ru-p-buenos-aires-argentina-krasivo-6.jpg'),
                      Image.network('https://mykaleidoscope.ru/x/uploads/posts/2022-09/1663154968_6-mykaleidoscope-ru-p-buenos-aires-argentina-krasivo-6.jpg'),
                      Image.network('https://mykaleidoscope.ru/x/uploads/posts/2022-09/1663154968_6-mykaleidoscope-ru-p-buenos-aires-argentina-krasivo-6.jpg')
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

