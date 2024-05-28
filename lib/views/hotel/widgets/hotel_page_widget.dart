import 'package:flutter/material.dart';
import 'package:stay_travel_v3/models/hotel.dart';
import 'package:stay_travel_v3/themes/colors.dart';
import 'package:stay_travel_v3/themes/text_styles.dart';

class HotelPageWidget extends StatefulWidget {
  final Hotel hotel;

  const HotelPageWidget({super.key, required this.hotel});

  @override
  State<HotelPageWidget> createState() => _HotelPageWidgetState();
}

class _HotelPageWidgetState extends State<HotelPageWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
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
            widget.hotel.name,
            style: AppTextStyles.headerStyle.copyWith(fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ),
        SliverToBoxAdapter(
          child: Text(
            widget.hotel.address,
            style: AppTextStyles.bodyTextStyle.copyWith(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 5)),
        SliverToBoxAdapter(
            child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.grey3, width: 1),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  width: 150,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '4.5',
                        style: AppTextStyles.headerStyle,
                      ),
                      Text(
                        'rating',
                        style:
                            AppTextStyles.bodyTextStyle.copyWith(fontSize: 18),
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.grey3, width: 1),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  width: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '8.6K',
                        style: AppTextStyles.headerStyle,
                      ),
                      Text(
                        'people rated',
                        style:
                            AppTextStyles.bodyTextStyle.copyWith(fontSize: 18),
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 5),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.grey3, width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '2.3K',
                    style: AppTextStyles.headerStyle,
                  ),
                  Text(
                    'people saved',
                    style: AppTextStyles.bodyTextStyle.copyWith(fontSize: 18),
                  )
                ],
              ),
            ),
            const SizedBox(height: 5),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.grey3, width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.abc),
                      Icon(Icons.abc),
                      Icon(Icons.abc),
                      Icon(Icons.abc),
                    ],
                  ),
                  Text(
                    'hotel features',
                    style: AppTextStyles.bodyTextStyle.copyWith(fontSize: 18),
                  )
                ],
              ),
            ),
          ],
        )),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Фотографии',
                style: AppTextStyles.headerStyle
                    .copyWith(fontSize: 22, fontWeight: FontWeight.w500),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 200,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        child: SizedBox(
                          width: 300,
                          child: Image.network(
                              'https://mykaleidoscope.ru/x/uploads/posts/2022-09/1663154968_6-mykaleidoscope-ru-p-buenos-aires-argentina-krasivo-6.jpg',
                                                ),
                        ));
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 10),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
