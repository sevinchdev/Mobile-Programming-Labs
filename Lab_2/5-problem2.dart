// Problem 2: single-line and multi-line comments explaining a mathematical calculation.

import 'dart:math';

void main() {
  double a = 1, b = -3, c = 2;

  // Discriminant of the quadratic equation: D = b^2 - 4ac
  double d = b * b - 4 * a * c;

  /* If D < 0 there are no real roots,
     if D == 0 there is one root,
     if D > 0 there are two roots. */
  if (d < 0) {
    print('No real roots');
  } else if (d == 0) {
    print('One root: ${-b / (2 * a)}');
  } else {
    print('Roots: ${(-b + sqrt(d)) / (2 * a)} and ${(-b - sqrt(d)) / (2 * a)}');
  }
}
