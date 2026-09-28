// Problem 6: compare interface implementation (implements) vs mixin composition (with) via code examples.

class Logger {
  void log(String message) => print('LOG: $message');
}

class CustomLogger implements Logger {
  @override
  void log(String message) => print('CUSTOM: $message');
}

mixin LoggerMixin {
  void log(String message) => print('LOG: $message');
}

class Service with LoggerMixin {}

void main() {
  Logger a = CustomLogger();
  a.log('implements: must write its own body');

  Service s = Service();
  s.log('with: reuses the mixin body');
}
