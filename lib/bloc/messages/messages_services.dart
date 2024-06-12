import 'package:stay_travel_v3/models/message.dart';
import 'package:stay_travel_v3/services/api_service.dart';
import 'package:stay_travel_v3/utils/logger.dart';

class MessagesServices {
  Future<List<Message>> fetchMessages() async {
    try {
      final response = await ApiService.instance.dio.get('/messages/', options: ApiService.instance.getHeaders());

        List<dynamic> data = response.data;
        return data.map((json) => Message.fromJson(json)).toList();

    } catch (e) {
      Logger.log(e.toString(), level: LogLevel.error);
      return [];
    }
  }

  Future<bool> sendMessage(Message message) async {
    try {
      final response = await ApiService.instance.dio.post(
        '/messages/',
        data: message.toJson(),
        options: ApiService.instance.getHeaders()
      );

      if (response.data['message']) {
        return true;
      } else {
        return false;
      }

    } catch (e) {
      Logger.log(e.toString(), level: LogLevel.error);
      return false;
    }
  }
}