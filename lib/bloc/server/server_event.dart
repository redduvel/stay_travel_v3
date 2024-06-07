
import 'package:equatable/equatable.dart';

abstract class ServerEvent extends Equatable {
  const ServerEvent();

  @override
  List<dynamic> get props => []; 
}

class ServerStatusCheck extends ServerEvent {}