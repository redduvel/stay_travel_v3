import 'dart:math';

class AppFunctions {
  static String getGreetingMessage() {
    var now = DateTime.now();
    var hour = now.hour;

    var dayGreetings = [
      "куда отправимся?",
      "какие у нас планы?",
      "куда поедем?",
      "что будем делать сегодня?"
    ];

    var nightGreetings = [
      "где переночуем?",
      "ищем отель?",
      "где будем спать?",
      "давайте найдём место для ночлега!"
    ];

    var random = Random();
    var randomDayGreeting = dayGreetings[random.nextInt(dayGreetings.length)];
    var randomNightGreeting = nightGreetings[random.nextInt(nightGreetings.length)];

    if (hour >= 6 && hour < 12) {
      return "Доброе утро, $randomDayGreeting";
    } else if (hour >= 12 && hour < 18) {
      return "Добрый день, $randomDayGreeting";
    } else if (hour >= 18 && hour < 22) {
      return "Добрый вечер, $randomDayGreeting";
    } else {
      return "Доброй ночи, $randomNightGreeting";
    }
  }
}