// Problem 3: initializer list in a constructor to validate input boundaries prior to field assignment.

class Rectangle {
  final double width;
  final double height;

  Rectangle(double width, double height)
      : width = _check(width, 'width'),
        height = _check(height, 'height');

  static double _check(double value, String label) {
    if (value <= 0) {
      throw ArgumentError('$label must be positive, got $value');
    }
    return value;
  }

  double get area => width * height;
}

void main() {
  print('Area: ${Rectangle(3, 4).area}');
  try {
    Rectangle(-1, 5);
  } on ArgumentError catch (e) {
    print('Error: ${e.message}');
  }
}
