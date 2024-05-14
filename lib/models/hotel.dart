import 'review.dart';

class Hotel {
  final String id;
  final String name;
  final String description;
  final String address;
  final double averageRating;
  final List<String> images;
  final List<Review> reviews;
  final bool isDeleted;
  final DateTime createdAt;

  Hotel({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.averageRating,
    required this.images,
    required this.reviews,
    this.isDeleted = false,
    required this.createdAt,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      address: json['address'],
      averageRating: json['averageRating'].toDouble(),
      images: List<String>.from(json['images']),
      reviews: List<Review>.from(json['reviews'].map((model) => Review.fromJson(model))),
      isDeleted: json['isDeleted'] ?? false,
      createdAt: DateTime.parse(json['createAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'address': address,
      'averageRating': averageRating,
      'images': images,
      'reviews': reviews.map((review) => review.toJson()).toList(),
      'isDeleted': isDeleted,
      'createAt': createdAt.toIso8601String(),
    };
  }
}
