// Problem 4: combine multiple mixins (Walker, Swimmer, Flyable) onto a single Duck class.

mixin Walker {
  void walk() => print('$runtimeType is walking');
}

mixin Swimmer {
  void swim() => print('$runtimeType is swimming');
}

mixin Flyable {
  void fly() => print('$runtimeType is flying');
}

class Duck with Walker, Swimmer, Flyable {}

void main() {
  var duck = Duck();
  duck.walk();
  duck.swim();
  duck.fly();
}
