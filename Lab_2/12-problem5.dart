// Problem 5: capture and print full execution stack traces during debugging scenarios.

void level3() => throw StateError('Something broke');

void level2() => level3();

void level1() => level2();

void main() {
  try {
    level1();
  } catch (e, stackTrace) {
    print('Error: $e');
    print('Stack trace:');
    print(stackTrace);
  }
}
