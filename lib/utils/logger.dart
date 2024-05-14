import 'dart:developer' as developer;

enum LogLevel { debug, info, warning, error }

class Logger {
  static void log(String message, {LogLevel level = LogLevel.debug}) {
    switch (level) {
      case LogLevel.debug:
        developer.log(message, name: 'DEBUG');
        break;
      case LogLevel.info:
        developer.log(message, name: 'INFO');
        break;
      case LogLevel.warning:
        developer.log(message, name: 'WARNING');
        break;
      case LogLevel.error:
        developer.log(message, name: 'ERROR');
        break;
    }
  }
}