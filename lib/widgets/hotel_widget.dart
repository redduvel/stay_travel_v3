import 'dart:convert';
import 'dart:typed_data';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:stay_travel_v3/bloc/hotels/hotels_bloc.dart';
import 'package:stay_travel_v3/bloc/hotels/hotels_event.dart';
import 'package:stay_travel_v3/controllers/features_controller.dart';
import 'package:stay_travel_v3/services/local_storage_service.dart';
import 'package:stay_travel_v3/themes/colors.dart';
import 'package:stay_travel_v3/themes/text_styles.dart';
import 'package:stay_travel_v3/models/hotel.dart';
import 'package:stay_travel_v3/views/hotel/hotel_page.dart';

class HotelWidget extends StatefulWidget {
  final Hotel hotel;
  const HotelWidget({super.key, required this.hotel});

  @override
  State<HotelWidget> createState() => _HotelWidgetState();
}

class _HotelWidgetState extends State<HotelWidget> {

  void toggleFavorite() {
    if (LocalStorageService.getToken() == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Сначала войдите в аккаунт.'))
      );
      return;
    }

    if (widget.hotel.isFavorite) {
      setState(() {
        widget.hotel.isFavorite = false;
      });
      BlocProvider.of<HotelsBloc>(context).add(RemoveHotelFromFavorites(widget.hotel));
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Отель удален из избранных.'),
      ));
    } else {
      setState(() {
        widget.hotel.isFavorite = true;
      });
      BlocProvider.of<HotelsBloc>(context).add(AddHotelToFavorites(widget.hotel));
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Отель добавлен в избранные.'),
      ));
    }
  }

    Uint8List _decodeImage(String base64String) {
    return base64Decode(base64String);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context, 
          isScrollControlled: true,
          builder:(context) {
            return HotelPage(hotelId: widget.hotel.id);
          },

        );
        //Navigator.pushNamed(context, Routes.hotelPage, arguments: widget.hotel.id);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7.5),
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                child: widget.hotel.images.isNotEmpty
                    ? Image.memory(
                        _decodeImage(widget.hotel.images[0]),
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'lib/assets/hotel.jpg',
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
                    ExpandableText(
                      widget.hotel.description, 
                      linkColor: AppColors.orange2,
                      maxLines: 4,
                      expandText: 'Показать больше',
                      style: AppTextStyles.bodyTextStyle.copyWith(
                      fontSize: 16,
                      color: AppColors.black,
                    
                    ),
                    ),
                    /*ExpandableText(text: widget.hotel.description, style: AppTextStyles.bodyTextStyle.copyWith(
                      fontSize: 16,
                      color: AppColors.black,
                    
                    ),
                    ),*/
                    const SizedBox(height: 5),
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        border: Border.symmetric(horizontal: BorderSide(color: AppColors.grey2, width: 0.5))
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 5),
                    ),
                    Consumer<FeaturesController>(
                      builder: (context, featureProvider, child) {
                        return Row(
                          children: List.generate(
                            widget.hotel.features.length, 
                            (index) {
                              final feature = widget.hotel.features[index];
                            final isSelected = featureProvider.selectedFeatures.any((selectedFeature) => selectedFeature.id == feature.id);
        
                              return Container(
                                margin: const EdgeInsets.symmetric(horizontal: 2.5),
                                child: Icon(
                                  widget.hotel.features[index].iconData,
                                  color: isSelected ? AppColors.orange : AppColors.grey2,
                                ),
                              );
                            }
                          )
                        );
                      },
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
                        IconButton(
                          onPressed: () {
                            toggleFavorite();
                          },
                          isSelected: widget.hotel.isFavorite,
                          selectedIcon: const Icon(Icons.favorite, color: AppColors.orange,),
                          icon: const Icon(Icons.favorite_outline)
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
