// Problem 2: function dividing two numbers that catches UnsupportedError when dividing by zero.

int safeDivide(int a, int b) {
  try {
    return a ~/ b;
  } on UnsupportedError catch (e) {
    print('Caught UnsupportedError: ${e.message}');
    return 0;
  }
}

void main() {
  print('10 ~/ 2 = ${safeDivide(10, 2)}');
  print('10 ~/ 0 = ${safeDivide(10, 0)}');
}
