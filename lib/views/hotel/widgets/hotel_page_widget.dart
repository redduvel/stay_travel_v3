import 'dart:convert';
import 'dart:typed_data';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:stay_travel_v3/bloc/review/review_bloc.dart';
import 'package:stay_travel_v3/bloc/review/review_event.dart';
import 'package:stay_travel_v3/bloc/review/review_state.dart';
import 'package:stay_travel_v3/models/hotel.dart';
import 'package:stay_travel_v3/themes/colors.dart';
import 'package:stay_travel_v3/themes/text_styles.dart';
import 'package:stay_travel_v3/utils/static_functions.dart';

class HotelPageWidget extends StatefulWidget {
  final Hotel hotel;

  const HotelPageWidget({super.key, required this.hotel});

  @override
  State<HotelPageWidget> createState() => _HotelPageWidgetState();
}

class _HotelPageWidgetState extends State<HotelPageWidget> {
  Uint8List _decodeImage(String base64String) {
    return base64Decode(base64String);
  }

  @override
  void initState() {
    context.read<ReviewBloc>().add(FetchHotelReviews(hotelId: widget.hotel.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            child: Container(
              width: double.infinity,
              height: 200,
              child: widget.hotel.images.isNotEmpty
                  ? Image.memory(
                      _decodeImage(widget.hotel.images[0]),
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'lib/assets/hotel.jpg',
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.hotel.name,
                  style: AppTextStyles.headerStyle.copyWith(fontSize: 26),
                  textAlign: TextAlign.left,
                ),
                Text(
                  widget.hotel.address,
                  style: AppTextStyles.bodyTextStyle.copyWith(fontSize: 18),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 5)),
        SliverToBoxAdapter(
          child: Column(
            children: [
              Card(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Описание',
                        style: AppTextStyles.headerStyle.copyWith(fontSize: 20),
                      ),
                      Text(
                        widget.hotel.description,
                        style:
                            AppTextStyles.bodyTextStyle.copyWith(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Card(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
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
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      width: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.hotel.totalClients}',
                            style: AppTextStyles.headerStyle
                                .copyWith(color: AppColors.orange2),
                          ),
                          Text(
                            'Посетили',
                            style: AppTextStyles.bodyTextStyle
                                .copyWith(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
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
                        style:
                            AppTextStyles.bodyTextStyle.copyWith(fontSize: 18),
                      ),
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
                        }),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Особенности',
                        style:
                            AppTextStyles.bodyTextStyle.copyWith(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
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
                  itemCount: widget.hotel.images.length,
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: SizedBox(
                        width: 300,
                        child: Image.memory(
                          _decodeImage(widget.hotel.images[index]),
                          width: 300,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 10),
                ),
              ),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: Text(
            'Отзывы',
            style: AppTextStyles.headerStyle
                .copyWith(fontSize: 22, fontWeight: FontWeight.w500),
            textAlign: TextAlign.left,
          ),
        ),
        BlocBuilder<ReviewBloc, ReviewState>(builder: (context, state) {
          if (state is ReviewsLoaded) {
            return SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                              backgroundImage: state.reviews[index].avatar != null ?
                              MemoryImage(base64Decode(state.reviews[index].avatar!)) : null,
                              radius: 24,
                            ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.reviews[index].userName!,
                                style: AppTextStyles.subheaderStyle
                                    .copyWith(color: AppColors.black),
                              ),
                              Text(
                                AppFunctions.formatTimeAgo(state.reviews[index].createdAt!),
                                style: AppTextStyles.subheaderStyle
                                    .copyWith(fontSize: 14),
                              )
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      RatingBar.builder(
                        initialRating: state.reviews[index].rating,
                        unratedColor: AppColors.grey3,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 24,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 2.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          // Handle rating update
                        },
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ExpandableText(
                        state.reviews[index].text,
                        expandText: 'Показать больше',
                        maxLines: 4,
                        style: AppTextStyles.titleTextStyle,
                      )
                    ],
                  ),
                ),
              );
            }, childCount: state.reviews.length),
          );
          } else if (state is ReviewsLoaded && state.reviews.isEmpty) {
            return const SliverToBoxAdapter(child: Text('Нет отзывов'));
          } else if (state is ReviewsLoading) {
            return const SliverToBoxAdapter(
              child: Center(
                child: LoadingIndicator(indicatorType: Indicator.ballSpinFadeLoader),
              ),
            );
          } else {
            return const SliverToBoxAdapter(
              child: Center(
                child: Text('Ошибка загрузки'),
              ),
            );
          }
          
        })
      ],
    );
  }
}
