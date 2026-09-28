// Problem 4: multi-level inheritance hierarchy (Shape -> Polygon -> Triangle).

class Shape {
  final String name;

  Shape(this.name);

  void describe() => print('I am a $name');
}

class Polygon extends Shape {
  final int sides;

  Polygon(super.name, this.sides);

  void showSides() => print('$name has $sides sides');
}

class Triangle extends Polygon {
  final double base;
  final double height;

  Triangle(this.base, this.height) : super('Triangle', 3);

  double get area => 0.5 * base * height;
}

void main() {
  var t = Triangle(4, 5);
  t.describe();
  t.showSides();
  print('Area: ${t.area}');
}
