import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stay_travel_v3/bloc/auth/auth_service.dart';
import 'package:stay_travel_v3/models/user.dart';
import 'package:stay_travel_v3/services/local_storage_service.dart';
import 'package:stay_travel_v3/utils/logger.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late User? currentUser;
  final AuthService authService;

  AuthBloc(this.authService) : super(AuthInitial()) {
    on<LoginEvent>(_onLoginEvent);
    on<RegisterEvent>(_onRegisterEvent);
    on<CheckAuthEvent>(_onCheckAuthEvent);
    on<LogoutEvent>(_logoutEvent);
  }

  Future<void> _onLoginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await authService.login(event.emailOrNumber, event.password);
      if (user != null) {
        emit(AuthAuthenticated(user: user));
        currentUser = user;
      } else {
        emit(const AuthError('Проверьте правильность введенных данных.', AuthErrorType.serverError));
      }
    } catch (e) {
      emit(AuthError(e.toString(), AuthErrorType.serverError));
    }
  }

  Future<void> _onRegisterEvent(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await authService.register(event.userData);
      
      if (user != null) {
        emit(AuthAuthenticated(user: user));
        currentUser = user;
      } else {
        emit(const AuthError('Ошибка регистрации', AuthErrorType.serverError));
      }
    } catch (e) {
      emit(AuthError(e.toString(), AuthErrorType.serverError));
    }
  }

  Future<void> _onCheckAuthEvent(CheckAuthEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final token = LocalStorageService.getToken();
      if (token != null) {
        final user = await authService.me(token);
        if (user != null) {
          emit(AuthAuthenticated(user: user));
          Logger.log("Find user", level: LogLevel.warning);
          currentUser = user;
        } else {
          emit(const AuthError('Устаревшая сессия.', AuthErrorType.outdatedSession));
        }
      } else {
        emit(const AuthError('Не найдено сохранненого аккаунта.', AuthErrorType.outdatedSession));
      }
    } catch (e) {
      emit(AuthError(e.toString(), AuthErrorType.serverError));
    }
  }

  Future<void> _logoutEvent(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(AuthInitial());
    currentUser = null;
    await LocalStorageService.clear();
  }
}

