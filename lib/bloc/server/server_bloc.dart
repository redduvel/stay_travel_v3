

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stay_travel_v3/bloc/server/server_event.dart';
import 'package:stay_travel_v3/bloc/server/server_service.dart';
import 'package:stay_travel_v3/bloc/server/server_state.dart';

class ServerBloc extends Bloc<ServerEvent, ServerState> {
  final ServerService serverService;
  
  ServerBloc(this.serverService) : super(ServerInitial()) {
    on<ServerStatusCheck>(_checkServerStatus);
  }

  Future<void> _checkServerStatus(ServerStatusCheck event, Emitter<ServerState> emit) async {
    emit(ServerLoading());
    try {
      final status = await serverService.pingServer();
      if (status) {
        emit(ServerAviable(status));
      } else {
        emit(const ServerNotAviable());
      }
    } catch (e) {
      emit(const ServerNotAviable());
    }
  }

}

