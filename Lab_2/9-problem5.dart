// Problem 5: restrict mixin application to specific superclasses using the on keyword.

class Animal {
  void breathe() => print('$runtimeType is breathing');
}

mixin Swimmer on Animal {
  void swim() {
    breathe();
    print('$runtimeType is swimming');
  }
}

class Fish extends Animal with Swimmer {}

void main() {
  Fish().swim();
}
