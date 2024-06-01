import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stay_travel_v3/services/api_service.dart';
import 'auth_event.dart';
import 'auth_state.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginEvent>(_onLoginEvent);
    on<RegisterEvent>(_onRegisterEvent);
  }

  Future<void> _onLoginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await ApiService.instance.login(event.emailOrNumber, event.password);
      if (user != null) {
        emit(AuthAuthenticated());
      } else {
        emit(const AuthError('Проверьте правильность введенных данных.'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onRegisterEvent(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final userData = {
        'emailOrNumber': event.emailOrNumber,
        'password': event.password,
        'fullname': event.fullname
      };

      final user = await ApiService.instance.register(userData);
      
      if (user != null) {
        emit(AuthAuthenticated());
      } else {
        emit(const AuthError('Registration failed'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}

