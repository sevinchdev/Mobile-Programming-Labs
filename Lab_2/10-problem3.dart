// Problem 3: runtime type checks using is and type casting using as.

class Circle {
  final double r;
  Circle(this.r);
}

void inspect(Object value) {
  if (value is String) {
    print('String of length ${value.length}');
  } else if (value is int) {
    print('int, doubled = ${value * 2}');
  } else if (value is Circle) {
    print('Circle with radius ${value.r}');
  } else {
    print('Unknown type: ${value.runtimeType}');
  }
}

void main() {
  inspect('hello');
  inspect(21);
  inspect(Circle(1.5));
  inspect(3.14);

  Object o = Circle(2.5);
  Circle c = o as Circle;
  print('Cast worked, radius = ${c.r}');

  Object text = 'not a number';
  try {
    int n = text as int;
    print(n);
  } on TypeError {
    print('Cast failed: String cannot be cast to int');
  }
}
