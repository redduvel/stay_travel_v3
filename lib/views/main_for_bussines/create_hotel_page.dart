import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:stay_travel_v3/bloc/hotels/hotels_bloc.dart';
import 'package:stay_travel_v3/bloc/hotels/hotels_event.dart';
import 'package:stay_travel_v3/bloc/hotels/hotels_state.dart';
import 'package:stay_travel_v3/controllers/features_controller.dart';
import 'package:stay_travel_v3/themes/text_styles.dart';
import 'package:stay_travel_v3/widgets/custom_button.dart';
import 'package:stay_travel_v3/widgets/hotel_features.dart';
import 'package:stay_travel_v3/widgets/input_field.dart';

class CreateHotelPage extends StatefulWidget {
  const CreateHotelPage({super.key});

  @override
  _CreateHotelPageState createState() => _CreateHotelPageState();
}

class _CreateHotelPageState extends State<CreateHotelPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final List<String> _photos = [];

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images != null) {
      setState(() {
        _photos.addAll(images.map((image) => image.path).toList());
      });
    }
  }

  void _createHotel() async {
    final name = _nameController.text;
    final address = _addressController.text;
    final description = _descriptionController.text;

    final featureProvider =
        Provider.of<FeaturesController>(context, listen: false);

    if (name.isNotEmpty &&
        address.isNotEmpty &&
        description.isNotEmpty &&
        _photos.isNotEmpty) {
      context.read<HotelsBloc>().add(CreateHotel(hotelData: {
            'name': name,
            'address': address,
            'description': description,
            'features': featureProvider.selectedFeatures
                .map((feature) => feature.id)
                .toList(),
            'images': _photos,
          }));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Пожалуйста заполните все поля.')),
      );
    }
  }

  Map<String, IconData> hotelFeatures = {
    'Бесплатный Wi-Fi': Icons.wifi,
    'Спа-центр': Icons.spa,
    'Завтрак включен': Icons.egg_alt,
    'Фитнес-центр': Icons.fitness_center,
    'Бассейн': Icons.pool_sharp,
    'Трансфер от/до аэропорта': Icons.airport_shuttle,
    'Парковка': Icons.local_parking,
    'Ресторан и бар': Icons.restaurant,
    'Конференц-залы': Icons.videocam,
    'Допуск с домашними животными': Icons.pets,
  };

  @override
  Widget build(BuildContext context) {
    return BlocListener<HotelsBloc, HotelsState>(
      listener: (context, state) {
        if (state is CreateHotelSuccessful) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Отель успешно создан.🥳')),
          );
        }

        if (state is CreateHotelError) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Ошибка создания отеля.')),
          );
        }
      },
      child: BlocBuilder<HotelsBloc, HotelsState>(builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Создание отеля'),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomScrollView(
              scrollDirection: Axis.vertical,
              slivers: [
                SliverToBoxAdapter(
                  child: TextFormField(
                    controller: _nameController,
                    decoration: textFieldDecoration('Название'),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 10),
                ),
                SliverToBoxAdapter(
                  child: TextFormField(
                    controller: _addressController,
                    decoration: textFieldDecoration('Адрес'),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 10),
                ),
                SliverToBoxAdapter(
                  child: TextField(
                    controller: _descriptionController,
                    decoration: textFieldDecoration('Описание').copyWith(
                        constraints: const BoxConstraints(
                      maxWidth: 500,
                      maxHeight: 120,
                    )),
                    maxLines: 5,
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 10,
                  ),
                ),
                const SliverToBoxAdapter(
                    child: HotelFeaturesList(height: 200, width: 500)),
                SliverToBoxAdapter(
                  child: CustomButton.normal(
                    text: 'Выбрать фото',
                    onPressed: () {
                      _pickImage();
                    },
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 10,),
                ),
                SliverToBoxAdapter(
                  child: Wrap(
                    children: _photos
                        .map((photo) => Stack(
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(4.0),
                                  child: Image.file(
                                    File(photo),
                                    width: 200,
                                    height: 200,
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: IconButton(
                                    icon: const Icon(Icons.close),
                                    onPressed: () {
                                      setState(() {
                                        _photos.remove(photo);
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ))
                        .toList(),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 100,),
                )
              ],
            ),
          ),
          bottomSheet: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton.load(
              onPressed: () {
                _createHotel();
              },
              mainAxisAlignment: MainAxisAlignment.center,
              widget: state is CreateHotelLoading
                  ? const LoadingIndicator(
                      indicatorType: Indicator.ballSpinFadeLoader,
                    )
                  : const Text(
                      'Создать',
                      style: AppTextStyles.subheaderBoldStyle,
                    ),
            ),
          ),
        );
      }),
    );
  }
}
