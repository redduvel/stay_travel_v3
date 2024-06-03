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
  final String emailOrNumber;
  final String password;
  final String fullname;

  const RegisterEvent(this.emailOrNumber, this.password, this.fullname);

  @override
  List<Object> get props => [emailOrNumber, password, fullname];
}

class CheckAuthEvent extends AuthEvent {}
