class Review {
  final String userId;
  final String hotelId;
  final String text;
  final DateTime? createdAt;
  final double rating;

  Review({
    required this.userId,
    required this.hotelId,
    required this.text,
    required this.rating,
    this.createdAt
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      createdAt: DateTime.parse(json['created_at']),
      userId: json['user_id'],
      hotelId: json['hotel_id'],
      text: json['text'],
      rating: json['rating'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'hotel_id': hotelId,
      'text': text,
      'rating': rating,
    };
  }
}
