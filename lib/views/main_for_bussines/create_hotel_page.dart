import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:stay_travel_v3/bloc/hotels/hotels_bloc.dart';
import 'package:stay_travel_v3/bloc/hotels/hotels_event.dart';
import 'package:stay_travel_v3/bloc/hotels/hotels_state.dart';
import 'package:stay_travel_v3/themes/text_styles.dart';
import 'package:stay_travel_v3/widgets/custom_button.dart';

class CreateHotelPage extends StatefulWidget {
  @override
  _CreateHotelPageState createState() => _CreateHotelPageState();
}

class _CreateHotelPageState extends State<CreateHotelPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _featuresController = TextEditingController();

  final List<String> _features = [];
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

  void _addFeature() {
    final feature = _featuresController.text;
    if (feature.isNotEmpty) {
      setState(() {
        _features.add(feature);
        _featuresController.clear();
      });
    }
  }

  void _createHotel() async {
    final name = _nameController.text;
    final address = _addressController.text;
    final description = _descriptionController.text;

    if (name.isNotEmpty &&
        address.isNotEmpty &&
        description.isNotEmpty &&
        _photos.isNotEmpty) {
      context.read<HotelsBloc>().add(CreateHotel(hotelData: {
            'name': name,
            'address': address,
            'description': description,
            'features': _features,
            'images': _photos,
          }));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Отель успешно создан.')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Пожалуйста заполните все поля.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HotelsBloc, HotelsState>(
      builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Create Hotel'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomScrollView(
            scrollDirection: Axis.vertical,
            slivers: [
              SliverToBoxAdapter(
                child: TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Название'),
                ),
              ),
              SliverToBoxAdapter(
                child: TextField(
                  controller: _addressController,
                  decoration: const InputDecoration(labelText: 'Адрес'),
                ),
              ),
              SliverToBoxAdapter(
                child: TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Описание'),
                  maxLines: 3,
                ),
              ),
              SliverToBoxAdapter(
                child: CustomButton.normal(
                  text: 'Выбрать фото',
                  onPressed: () {
                    _pickImage();
                  },
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
              SliverToBoxAdapter(
                child: Wrap(
                  children: _photos
                      .map((photo) =>
                          Image.file(File(photo), width: 100, height: 100))
                      .toList(),
                ),
              ),
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
    });
  }
}
