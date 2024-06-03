import 'package:flutter/material.dart';
import 'package:stay_travel_v3/models/hotel.dart';
import 'package:stay_travel_v3/themes/colors.dart';
import 'package:stay_travel_v3/themes/text_styles.dart';
import 'package:stay_travel_v3/utils/fake_data.dart';

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
            child: Image.network(FakeData.fakeImage),
          ),
        ),
        SliverToBoxAdapter(
          child: Text(
            widget.hotel.name,
            style: AppTextStyles.headerStyle.copyWith(fontSize: 26),
            textAlign: TextAlign.left,
          ),
        ),
        SliverToBoxAdapter(
          child: Text(
            widget.hotel.address,
            style: AppTextStyles.bodyTextStyle.copyWith(fontSize: 18),
            textAlign: TextAlign.left,
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 5)),
        SliverToBoxAdapter(
          child: Column(
            children: [
              Card(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Описание',
                        style:  AppTextStyles.headerStyle.copyWith(fontSize: 20)
                      ),
                      Text(
                        widget.hotel.description,
                        style: AppTextStyles.bodyTextStyle.copyWith(fontSize: 16)
                      ),
                    ],
                  )
                ),
              ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Card(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    width: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '4.5',
                          style: AppTextStyles.headerStyle
                              .copyWith(color: AppColors.orange2),
                        ),
                        Text(
                          'Рейтинг',
                          style: AppTextStyles.bodyTextStyle
                              .copyWith(fontSize: 18),
                        )
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    width: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '8.6K',
                          style: AppTextStyles.headerStyle
                              .copyWith(color: AppColors.orange2),
                        ),
                        Text(
                          'Посетили',
                          style: AppTextStyles.bodyTextStyle
                              .copyWith(fontSize: 18),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 5),
            Card(
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '2.3K',
                      style: AppTextStyles.headerStyle
                          .copyWith(color: AppColors.orange2),
                    ),
                    Text(
                      'Добавили в избранное',
                      style: AppTextStyles.bodyTextStyle.copyWith(fontSize: 18),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            Card(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        children: List.generate(widget.hotel.features.length,
                            (index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 2.5),
                        child: Icon(
                          widget.hotel.features[index].iconData,
                          color: AppColors.orange2,
                        ),
                      );
                    })),
                    const SizedBox(height: 5),
                    Text(
                      'Особенности',
                      style: AppTextStyles.bodyTextStyle.copyWith(fontSize: 18),
                    )
                  ],
                ),
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
                            const BorderRadius.all(Radius.circular(20)),
                        child: SizedBox(
                          width: 300,
                          child: Image.network(
                            FakeData.fakeImage,
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
