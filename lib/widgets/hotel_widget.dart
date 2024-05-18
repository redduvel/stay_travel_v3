import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:stay_travel_v3/themes/text_styles.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class HotelWidget extends StatefulWidget {
  const HotelWidget({super.key});

  @override
  State<HotelWidget> createState() => _HotelWidgetState();
}

class _HotelWidgetState extends State<HotelWidget> {
  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: Image.network(
                'https://images.divisare.com/images/c_limit,f_auto,h_2000,q_auto,w_3000/v1490958815/kkofaeofhmpw57956lq6/morris-adjmi-architects-mark-mahaney-matthew-williams-jimi-billingsley-wythe-hotel.jpg',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Seaside Resort', style: AppTextStyles.subheaderStyle,),
                  const Text('123 Ocean View Blvd, Santa Monica, CA'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RatingBar.builder(
                        initialRating: 3,
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
                          print(rating);
                        },
                      ),
                      IconButton(onPressed: () {}, icon: Icon(Icons.favorite_outline))
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}