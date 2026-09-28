// Problem 3: factorial with a standard for loop and a for-in loop.

int factorialFor(int n) {
  int result = 1;
  for (int i = 2; i <= n; i++) {
    result *= i;
  }
  return result;
}

int factorialForIn(int n) {
  int result = 1;
  for (final i in List<int>.generate(n, (index) => index + 1)) {
    result *= i;
  }
  return result;
}

void main() {
  print('5! (for)    = ${factorialFor(5)}');
  print('5! (for-in) = ${factorialForIn(5)}');
}
