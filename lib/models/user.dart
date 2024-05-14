class User {
  final String id;
  final String username;
  final String firstname;
  final String lastname;
  final String email;
  final String number;
  final String password;
  final DateTime dateOfBirth;
  final DateTime dateOfRegistration;
  final bool isDeleted;

  User({
    required this.id,
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.number,
    required this.password,
    required this.dateOfBirth,
    required this.dateOfRegistration,
    this.isDeleted = false,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      number: json['number'],
      password: json['password'],
      dateOfBirth: DateTime.parse(json['date_of_birth']),
      dateOfRegistration: DateTime.parse(json['date_of_reg']),
      isDeleted: json['isDeleted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'number': number,
      'password': password,
      'date_of_birth': dateOfBirth.toIso8601String(),
      'date_of_reg': dateOfRegistration.toIso8601String(),
      'isDeleted': isDeleted,
    };
  }
}
