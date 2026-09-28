// Problem 2: base class Animal and a derived class Dog overriding a makeSound() method.

class Animal {
  void makeSound() => print('Some generic animal sound');
}

class Dog extends Animal {
  @override
  void makeSound() => print('Woof!');
}

void main() {
  Animal a = Animal();
  Animal d = Dog();
  a.makeSound();
  d.makeSound();
}
