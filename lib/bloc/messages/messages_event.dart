import 'package:equatable/equatable.dart';
import 'package:stay_travel_v3/models/message.dart';

abstract class MessagesEvent extends Equatable {
  const MessagesEvent();

  @override
  List<Object> get props => [];
}


class CreateMessage extends MessagesEvent {
  final Message message;

  const CreateMessage({required this.message});

  @override
  List<Object> get props => [message];
}


class FetchMessages extends MessagesEvent {}