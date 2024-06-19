import 'package:flutter/material.dart';
import 'package:stay_travel_v3/models/feature.dart';

class FeaturesController with ChangeNotifier {
  final List<Feature> _selectedFeatures = [];

  List<Feature> get selectedFeatures => _selectedFeatures;

  void toggleFeature(Feature feature) {
    if (_selectedFeatures.contains(feature)) {
      _selectedFeatures.remove(feature);
    } else {
      _selectedFeatures.add(feature);
    }
    notifyListeners();
  }

  bool isSelected(Feature feature) => _selectedFeatures.contains(feature);

  List<Feature> getSelectedFeatures() => _selectedFeatures;
}
