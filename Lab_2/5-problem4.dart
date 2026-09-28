// Problem 4: Markdown formatting inside a Dartdoc comment including bold text, 
// bullet points, and code blocks.


class Calculator {
 
  int add(int a, int b) => a + b;

  int subtract(int a, int b) => a - b;

  int multiply(int a, int b) => a * b;
}

void main() {
  var calc = Calculator();
  print(calc.add(2, 3));
  print(calc.subtract(9, 4));
  print(calc.multiply(3, 5));
}
