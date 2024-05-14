class Booking {
  final String id;
  final String userId;
  final String hotelId;
  final DateTime createdAt;
  final DateTime startDate;
  final DateTime endDate;
  final String description;
  final String status;
  final bool isDeleted;

  Booking({
    required this.id,
    required this.userId,
    required this.hotelId,
    required this.createdAt,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.status,
    this.isDeleted = false,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      userId: json['user_id'],
      hotelId: json['hotel_id'],
      createdAt: DateTime.parse(json['createAt']),
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      description: json['description'],
      status: json['status'],
      isDeleted: json['isDeleted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'hotel_id': hotelId,
      'createAt': createdAt.toIso8601String(),
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'description': description,
      'status': status,
      'isDeleted': isDeleted,
    };
  }
}
