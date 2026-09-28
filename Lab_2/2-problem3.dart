// Problem 3: demonstrate the difference between final and const using DateTime.now().

void main() {
  final DateTime finalTime = DateTime.now();
  const int constNumber = 42;
  print('final (computed at runtime): $finalTime');
  print('const (known at compile time): $constNumber');
}
