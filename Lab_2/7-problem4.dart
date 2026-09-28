// Problem 4: enhanced enum that implements an abstract interface and defines computed methods.

abstract interface class Describable {
  String describe();
}

enum Planet implements Describable {
  mercury(3.3e23),
  venus(4.87e24),
  earth(5.97e24);

  final double mass;

  const Planet(this.mass);

  bool get isHeavy => mass > 1e24;

  @override
  String describe() => '$name has a mass of $mass kg (heavy: $isHeavy)';
}

void main() {
  for (final p in Planet.values) {
    print(p.describe());
  }
}
