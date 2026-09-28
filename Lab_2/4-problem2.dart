// Problem 2: arrow syntax function bool isEven(int n) returning true if a number is even.

bool isEven(int n) => n % 2 == 0;

void main() {
  print('isEven(4) = ${isEven(4)}');
  print('isEven(7) = ${isEven(7)}');
}
