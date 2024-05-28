import 'package:flutter/material.dart';

class FeaturesController with ChangeNotifier {
  final List<String> _selectedFeatures = [];

  List<String> get selectedFeatures => _selectedFeatures;

  void toggleFeature(String feature) {
    if (_selectedFeatures.contains(feature)) {
      _selectedFeatures.remove(feature);
    } else {
      _selectedFeatures.add(feature);
    }
    notifyListeners();
  }

  bool isSelected(String feature) {
    return _selectedFeatures.contains(feature);
  }
}
