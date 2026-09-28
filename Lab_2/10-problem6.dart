// Problem 6: Strategy Design Pattern using polymorphic interface delegates.

abstract class DiscountStrategy {
  double apply(double price);
}

class NoDiscount implements DiscountStrategy {
  @override
  double apply(double price) => price;
}

class PercentDiscount implements DiscountStrategy {
  final double percent;
  PercentDiscount(this.percent);

  @override
  double apply(double price) => price * (1 - percent / 100);
}

class FixedDiscount implements DiscountStrategy {
  final double amount;
  FixedDiscount(this.amount);

  @override
  double apply(double price) => price - amount;
}

class Checkout {
  DiscountStrategy strategy;

  Checkout(this.strategy);

  double total(double price) => strategy.apply(price);
}

void main() {
  var checkout = Checkout(NoDiscount());
  print('No discount: ${checkout.total(100)}');

  checkout.strategy = PercentDiscount(15);
  print('15% off: ${checkout.total(100)}');

  checkout.strategy = FixedDiscount(20);
  print('20 off: ${checkout.total(100)}');
}
