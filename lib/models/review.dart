class Review {
  final String userId;
  final String hotelId;
  final String text;
  final DateTime? createdAt;
  final double rating;
  final String? avatar;
  final String? userName;

  Review({
    required this.userId,
    required this.hotelId,
    required this.text,
    required this.rating,
    this.createdAt,
    this.avatar,
    this.userName
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      createdAt: DateTime.parse(json['created_at']),
      userId: json['user_id'],
      hotelId: json['hotel_id'],
      text: json['text'],
      rating: json['rating'].toDouble(),
      avatar: json['user_avatar'],
      userName: json['user_first_name']
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
