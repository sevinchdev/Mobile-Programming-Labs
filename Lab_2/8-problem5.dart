// Problem 5: abstract base class with concrete and abstract methods enforced on subclasses.

abstract class Shape {
  double area();

  void describe() {
    print('$runtimeType with area ${area().toStringAsFixed(2)}');
  }
}

class Circle extends Shape {
  final double radius;
  Circle(this.radius);

  @override
  double area() => 3.14159 * radius * radius;
}

class Square extends Shape {
  final double side;
  Square(this.side);

  @override
  double area() => side * side;
}

void main() {
  Circle(2).describe();
  Square(3).describe();
}
