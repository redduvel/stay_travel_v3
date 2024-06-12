import 'package:equatable/equatable.dart';
import 'package:stay_travel_v3/models/message.dart';

abstract class MessageState extends Equatable {
  const MessageState();

  @override
  List<Object> get props => [];
}

class MessageInitial extends MessageState {}

class MessageLoading extends MessageState {}

class MessageLoaded extends MessageState {
  final List<Message> messages;

  const MessageLoaded({required this.messages});

  @override
  List<Object> get props => [messages];
}

class MessageSended extends MessageState{
  final bool result;

  const MessageSended({required this.result});

  @override
  List<Object> get props => [result];
}

class  MessageError extends MessageState {
  final String message;

  const MessageError({required this.message});

  @override
  List<Object> get props => [message];
}

