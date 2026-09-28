// Problem 4: Singleton pattern class using a private constructor and static factory constructor.

class AppSettings {
  static final AppSettings _instance = AppSettings._internal();

  factory AppSettings() => _instance;

  AppSettings._internal();

  String theme = 'light';
}

void main() {
  var a = AppSettings();
  var b = AppSettings();

  a.theme = 'dark';

  print('b.theme = ${b.theme}');
  print('Same instance: ${identical(a, b)}');
}
