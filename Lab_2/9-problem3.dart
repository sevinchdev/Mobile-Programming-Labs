// Problem 3: mixin Flyable with a method fly() applied to a Bird class.

mixin Flyable {
  void fly() => print('$runtimeType is flying');
}

class Bird with Flyable {}

void main() {
  Bird().fly();
}
