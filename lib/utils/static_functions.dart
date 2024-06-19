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

  static String formatTimeAgo(DateTime dateTime) {
  Duration diff = DateTime.now().difference(dateTime);

  if (diff.inDays > 7) {
    return '${dateTime.day} ${_monthName(dateTime.month)}';
  } else if (diff.inDays >= 1) {
    return '${diff.inDays} ${_pluralize(diff.inDays, "день", "дня", "дней")} назад';
  } else if (diff.inHours >= 1) {
    return '${diff.inHours} ${_pluralize(diff.inHours, "час", "часа", "часов")} назад';
  } else if (diff.inMinutes >= 1) {
    return '${diff.inMinutes} ${_pluralize(diff.inMinutes, "минута", "минуты", "минут")} назад';
  } else {
    return 'Только что';
  }
}

static String _monthName(int month) {
  const List<String> months = [
    "января", "февраля", "марта", "апреля", "мая", "июня",
    "июля", "августа", "сентября", "октября", "ноября", "декабря"
  ];
  return months[month - 1];
}

static String _pluralize(int count, String one, String few, String many) {
  if (count % 10 == 1 && count % 100 != 11) {
    return one;
  } else if (count % 10 >= 2 && count % 10 <= 4 && (count % 100 < 10 || count % 100 >= 20)) {
    return few;
  } else {
    return many;
  }
}

}