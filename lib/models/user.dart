class User {
  final String id;
  final String username;
  final String firstname;
  final String lastname;
  final String email;
  final String number;
  final DateTime dateOfBirth;
  final DateTime dateOfRegistration;
  final String? avatar;
  final bool isDeleted;
  final bool isBusinessman;

  User({
    required this.id,
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.number,
    required this.dateOfBirth,
    required this.dateOfRegistration,
    required this.isBusinessman,
    this.isDeleted = false,
    this.avatar = ''
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      username: json['username'],
      firstname: json['first_name'],
      lastname: json['last_name'],
      email: json['email'] ?? '',
      number: json['number'] ?? '',
      dateOfBirth: DateTime.parse(json['date_of_birth']),
      dateOfRegistration: DateTime.parse(json['created_at']),
      avatar: json['avatar'],
      isDeleted: json['isDeleted'] ?? false,
      isBusinessman: json['isBusinessman'] ?? false
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'first_name': firstname,
      'last_name': lastname,
      'email': email,
      'number': number,
      'date_of_birth': dateOfBirth.toIso8601String(),
      'isDeleted': isDeleted,
      'isBusinessman': isBusinessman,
      'avatar': avatar
    };
  }
}
