// Problem 4: Markdown formatting inside a Dartdoc comment including bold text, 
// bullet points, and code blocks.


/// A simple calculator for basic arithmetic.
///
/// **Features:**
///
/// * Addition
/// * Subtraction
/// * Multiplication
///
/// Example usage:
///
/// ```dart
/// var calc = Calculator();
/// print(calc.add(2, 3)); // 5
/// ```
class Calculator {
  /// Returns the sum of [a] and [b].
  int add(int a, int b) => a + b;

  /// Returns [a] minus [b].
  int subtract(int a, int b) => a - b;

  /// Returns the product of [a] and [b].
  int multiply(int a, int b) => a * b;
}

void main() {
  var calc = Calculator();
  print(calc.add(2, 3));
  print(calc.subtract(9, 4));
  print(calc.multiply(3, 5));
}