// Problem 3: super-initializer parameters syntax (ElectricCar(super.brand)).

class Vehicle {
  final String brand;
  Vehicle(this.brand);
}

class ElectricCar extends Vehicle {
  final int batteryCapacity;
  ElectricCar(super.brand, this.batteryCapacity);
}

void main() {
  var car = ElectricCar('Tesla', 75);
  print('${car.brand}, battery ${car.batteryCapacity} kWh');
}
