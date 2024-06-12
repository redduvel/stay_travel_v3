import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:stay_travel_v3/themes/colors.dart';
import 'package:stay_travel_v3/themes/text_styles.dart';
import 'package:stay_travel_v3/utils/routes.dart';
import 'package:stay_travel_v3/models/hotel.dart';
import 'package:stay_travel_v3/widgets/custom_button.dart';

class UserHotelWidget extends StatefulWidget {
  final Hotel hotel;
  const UserHotelWidget({super.key, required this.hotel});

  @override
  State<UserHotelWidget> createState() => _UserHotelWidgetState();
}

class _UserHotelWidgetState extends State<UserHotelWidget> {
  Uint8List _decodeImage(String base64String) {
    return base64Decode(base64String);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, Routes.hotelPage,
          arguments: widget.hotel.id),
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
                    : Container(
                        height: 200,
                        width: double.infinity,
                        color: AppColors.grey,
                        child: const Center(
                          child: Text('Нет изображений'),
                        ),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.hotel.name,
                        style: AppTextStyles.subheaderStyle
                            .copyWith(color: AppColors.black)),
                    Text(widget.hotel.address,
                        style: AppTextStyles.bodyTextStyle),
                    Text('Создан: ${widget.hotel.createdAt}'),
                    /*ExpandableText(text: widget.hotel.description, style: AppTextStyles.bodyTextStyle.copyWith(
                      fontSize: 16,
                      color: AppColors.black,
                    
                    ),
                    ),*/
                    const SizedBox(height: 5),
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          border: Border.symmetric(
                              horizontal: BorderSide(
                                  color: AppColors.grey2, width: 0.5))),
                      margin: const EdgeInsets.symmetric(vertical: 5),
                    ),
                    Row(
                        children: List.generate(widget.hotel.features.length,
                            (index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 2.5),
                        child: Icon(
                          widget.hotel.features[index].iconData,
                          color: AppColors.grey2,
                        ),
                      );
                    })),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: AppColors.grey2,
                                    ),
                                    Text(widget.hotel.averageRating != null
                                        ? '${widget.hotel.averageRating}'
                                        : 'Нет рейтинга')
                                  ],
                                ),
                              ),
                            ),
                            const Card(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.people,
                                      color: AppColors.grey2,
                                    ),
                                    Text('100')
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {}, icon: const Icon(Icons.edit)),
                            IconButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                    
                                    context: context,
                                    builder: (context) {
                                      return const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Wrap(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 7.5),
                                              child: CustomButton.normal(
                                                text: 'Скрыть',
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                foregroundColor: AppColors.background,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 7.5),
                                              child: CustomButton.normal(
                                                text: 'Удалить',
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                foregroundColor: AppColors.background,
                                                backgroundColor: AppColors.orange,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(Icons.settings)),
                          ],
                        )
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
