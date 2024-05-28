import 'package:flutter/material.dart';

class Feature {
  final String id;
  final String name;
  final String icon;
  final IconData iconData;

  Feature({
    required this.id,
    required this.name,
    required this.icon,
  }) : iconData = _getIconData(icon);
  
  factory Feature.fromJson(Map<String, dynamic> json) {
    return Feature(
      id: json['_id'],
      name: json['name'],
      icon: json['icon']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon
    };
  }

  static IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'wi-fi':
        return Icons.wifi;
      case 'spa':
        return Icons.spa;
      case 'egg_alt':
        return Icons.egg_alt;
      case 'fitness_center':
        return Icons.fitness_center;
      case 'pool_sharp':
        return Icons.pool_sharp;
      case 'airport_shuttle':
        return Icons.airport_shuttle;
      case 'local_parking':
        return Icons.local_parking;
      case 'restaurant':
        return Icons.restaurant;
      case 'videocam':
        return Icons.videocam;
      case 'pets':
        return Icons.pets;
      default:
        return Icons.help; // default icon if no match found
    }
  }
}
