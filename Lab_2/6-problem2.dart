// Problem 2: Person class with fields for name and age, plus a standard constructor.

class Person {
  String name;
  int age;

  Person(this.name, this.age);

  @override
  String toString() => 'Person(name: $name, age: $age)';
}

void main() {
  var p = Person('Sevinch', 20);
  print(p);
  p.age = 21;
  print(p);
}
