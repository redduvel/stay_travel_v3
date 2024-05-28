import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:stay_travel_v3/themes/colors.dart';
import 'package:stay_travel_v3/themes/text_styles.dart';
import 'package:stay_travel_v3/utils/routes.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:stay_travel_v3/models/hotel.dart';

class HotelWidget extends StatefulWidget {
  final Hotel hotel;
  const HotelWidget({super.key, required this.hotel});

  @override
  State<HotelWidget> createState() => _HotelWidgetState();
}

class _HotelWidgetState extends State<HotelWidget> {
  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: () => Navigator.pushNamed(context, Routes.hotelPage, arguments: widget.hotel.id),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: Image.network(
                /*widget.hotel.images.isNotEmpty ? widget.hotel.images[0] : */
                'https://images.divisare.com/images/c_limit,f_auto,h_2000,q_auto,w_3000/v1490958815/kkofaeofhmpw57956lq6/morris-adjmi-architects-mark-mahaney-matthew-williams-jimi-billingsley-wythe-hotel.jpg',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.hotel.name, style: AppTextStyles.subheaderStyle.copyWith(
                    color: AppColors.black
                  )),
                  Text(widget.hotel.address, style: AppTextStyles.bodyTextStyle),
                  Text(widget.hotel.description, style: AppTextStyles.bodyTextStyle.copyWith(
                    fontSize: 16,
                    color: AppColors.black
                  )),
                  const SizedBox(height: 5),
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      border: Border.symmetric(horizontal: BorderSide(color: AppColors.grey2, width: 0.5))
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                  ),
                  Row(
                    children: List.generate(
                      widget.hotel.features.length, 
                      (index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 2.5),
                          child: Icon(
                            widget.hotel.features[index].iconData,
                            color: AppColors.grey2,
                          ),
                        );
                      }
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      widget.hotel.averageRating != null ?
                      RatingBar.builder(
                        initialRating: widget.hotel.averageRating!,
                        unratedColor: AppColors.grey3,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 24,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          // Handle rating update
                        },
                      ) : 
                      const Text('Нет рейтинга'),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_outline)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
