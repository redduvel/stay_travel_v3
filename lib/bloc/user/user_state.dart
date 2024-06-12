import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserUpdating extends UserState {}

class UserUpdated extends UserState {
  final bool status;

  const UserUpdated(this.status);

  @override
  List<Object> get props => [status];
}

class UserPasswordUpdated extends UserState {
  final bool status;

  const UserPasswordUpdated(this.status);

  @override
  List<Object> get props => [status];
}

class UserErrorUpdated extends UserState {
  final String message;

  const UserErrorUpdated(this.message);

  @override
  List<Object> get props => [message];
}
