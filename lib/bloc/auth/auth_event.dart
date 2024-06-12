import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  final String emailOrNumber;
  final String password;

  const LoginEvent(this.emailOrNumber, this.password);

  @override
  List<Object> get props => [emailOrNumber, password];
}

class RegisterEvent extends AuthEvent {
  final Map<String, dynamic> userData;

  const RegisterEvent(this.userData);

  @override
  List<Object> get props => [userData];
}

class CheckAuthEvent extends AuthEvent {}

class LogoutEvent extends AuthEvent {}
