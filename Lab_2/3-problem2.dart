// Problem 2: check whether a given integer is positive, negative, or zero using an if-else chain.

String checkNumber(int n) {
  if (n > 0) {
    return 'positive';
  } else if (n < 0) {
    return 'negative';
  } else {
    return 'zero';
  }
}

void main() {
  for (final n in [5, -3, 0]) {
    print('$n is ${checkNumber(n)}');
  }
}
