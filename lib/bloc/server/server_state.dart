import 'package:equatable/equatable.dart';

abstract class ServerState extends Equatable {
  const ServerState();

  @override
  List<Object?> get props => [];
}

class ServerInitial extends ServerState {}

class ServerLoading extends ServerState {}

class ServerAviable extends ServerState {
  final bool status;

  const ServerAviable(this.status);
}

class ServerNotAviable  extends ServerState{
  final bool status = false;

  const ServerNotAviable();
}
