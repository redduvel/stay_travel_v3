import 'package:equatable/equatable.dart';
import 'package:stay_travel_v3/models/user.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UserUpdatePassword extends UserEvent{
  final String old_password;
  final String new_password;

  const UserUpdatePassword({required this.old_password, required this.new_password});

  @override
  List<Object> get props => [old_password, new_password];
}

class UserUpdate extends UserEvent {
  final User user;
  
  const UserUpdate({required this.user});
  
  @override
  List<Object> get props => [user];
}
