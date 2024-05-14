class Review {
  final String id;
  final String userId;
  final String hotelId;
  final String text;
  final DateTime createdAt;
  final double rating;

  Review({
    required this.id,
    required this.userId,
    required this.hotelId,
    required this.text,
    required this.createdAt,
    required this.rating,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      userId: json['user_id'],
      hotelId: json['hotel_id'],
      text: json['text'],
      createdAt: DateTime.parse(json['createAt']),
      rating: json['rating'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'hotel_id': hotelId,
      'text': text,
      'createAt': createdAt.toIso8601String(),
      'rating': rating,
    };
  }
}
