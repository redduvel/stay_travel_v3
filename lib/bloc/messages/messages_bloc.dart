
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stay_travel_v3/bloc/messages/messages_event.dart';
import 'package:stay_travel_v3/bloc/messages/messages_services.dart';
import 'package:stay_travel_v3/bloc/messages/messages_state.dart';
import 'package:stay_travel_v3/utils/logger.dart';

class MessagesBloc extends Bloc<MessagesEvent, MessageState> {
  final MessagesServices messagesServices;

  MessagesBloc(this.messagesServices) : super(MessageInitial()) {
    on<CreateMessage>(_onCreateMessage);
    on<FetchMessages>(_onFetchMessages);
  }


  Future<void> _onCreateMessage(CreateMessage event, Emitter<MessageState> emit) async {
      emit(MessageLoading());

    try {
      final result = await messagesServices.sendMessage(event.message);

      if (result) {
        emit(MessageSended(result: result));
      } else {
        emit(const MessageError(message: 'Ошибка отправки ответа.'));
      }      
    } catch (e) {
      Logger.log(e.toString(), level: LogLevel.error);
      emit(MessageError(message: e.toString()));
    }
  }

  Future<void> _onFetchMessages(FetchMessages event, Emitter<MessageState> emit) async {
    emit(MessageLoading());
    try {
      final messages = await messagesServices.fetchMessages();

      emit(MessageLoaded(messages: messages));
    } catch (e) {
      emit(MessageError(message: e.toString()));
    }
  }
}