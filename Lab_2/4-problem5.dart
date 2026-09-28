// Problem 5: recursive function to compute the N-th Fibonacci number.

int fibonacci(int n) {
  if (n <= 1) return n;
  return fibonacci(n - 1) + fibonacci(n - 2);
}

void main() {
  print('fibonacci(10) = ${fibonacci(10)}');
  print('First 10 numbers: ${[for (int i = 0; i < 10; i++) fibonacci(i)]}');
}
