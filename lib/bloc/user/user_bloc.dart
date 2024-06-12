import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stay_travel_v3/bloc/user/user_event.dart';
import 'package:stay_travel_v3/bloc/user/user_service.dart';
import 'package:stay_travel_v3/bloc/user/user_state.dart';
import 'package:stay_travel_v3/utils/logger.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserService userService;

  UserBloc(this.userService) : super(UserInitial()) {
    on<UserUpdate>(_onUpdateProfile);
    on<UserUpdatePassword>(_onUpdatePassword);
  }
  

  Future<void> _onUpdateProfile(UserUpdate event, Emitter<UserState> emit) async {
    try {
      emit(UserUpdating());
      final result = await userService.updateUserSettings(event.user);

      if (result) {
        emit(UserUpdated(result));
      } else {
        throw Exception('Неизвестная ошибка');
      }
    } catch (e) {
      Logger.log('Error update profile: $e', level: LogLevel.error);
      emit(UserErrorUpdated(e.toString()));
    }
  }

  Future<void> _onUpdatePassword(UserUpdatePassword event, Emitter<UserState> emit) async {
    try {
      emit(UserUpdating());
      final result = await userService.updatePassword(event.old_password, event.new_password);

      if (result) {
        emit(UserPasswordUpdated(result));
      } else {
        throw Exception('Неизвестная ошибка');
      }
    } catch (e) {
      Logger.log('Error update password: $e', level: LogLevel.error);
      emit(UserErrorUpdated(e.toString()));
    }
  }
}