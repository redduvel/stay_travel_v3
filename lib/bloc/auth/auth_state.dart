import 'package:equatable/equatable.dart';
import 'package:stay_travel_v3/models/user.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final User user;

  const AuthAuthenticated({required this.user});
  
  @override
  List<Object> get props => [user];
}

class AuthError extends AuthState {
  final AuthErrorType? type;
  final String message;

  const AuthError(this.message, this.type);

  @override
  List<Object> get props => [message];
}

enum AuthErrorType {
  outdatedSession,
  serverError
}
