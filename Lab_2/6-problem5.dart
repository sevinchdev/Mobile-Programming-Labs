// Problem 5: custom getter and setter properties enforcing domain constraints.

class Thermometer {
  double _celsius = 0;

  double get celsius => _celsius;

  set celsius(double value) {
    if (value < -273.15) {
      throw ArgumentError('Below absolute zero is impossible');
    }
    _celsius = value;
  }

  double get fahrenheit => _celsius * 9 / 5 + 32;
}

void main() {
  var t = Thermometer();
  t.celsius = 25;
  print('${t.celsius} C = ${t.fahrenheit} F');
  try {
    t.celsius = -500;
  } on ArgumentError catch (e) {
    print('Error: ${e.message}');
  }
}
