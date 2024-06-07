class Booking {
  final String? id;
  final List<String> userIds; // Изменено на массив userIds
  final String hotelId;
  final String? hotelName;
  final String? hotelAddress;
  final DateTime createdAt;
  final DateTime startDate;
  final DateTime endDate;
  final String description;
  final String status;
  final bool isDeleted;

  Booking({
    this.id,
    required this.userIds, // Изменено на массив userIds
    required this.hotelId,
    required this.createdAt,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.status,
    this.isDeleted = false,
    this.hotelName,
    this.hotelAddress
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['_id'],
      userIds: List<String>.from(json['users']), // Изменено на массив userIds
      hotelId: json['hotel_id'],
      hotelName: json['hotel_name'],
      hotelAddress: json['hotel_address'],
      createdAt: DateTime.parse(json['createdAt']),
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
      'users': userIds, // Изменено на массив userIds
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
