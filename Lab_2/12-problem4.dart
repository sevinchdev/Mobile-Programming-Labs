// Problem 4: use the on clause to handle specific exception types differently from generic exceptions.

void parseAndDivide(String a, String b) {
  try {
    int x = int.parse(a);
    int y = int.parse(b);
    print('$x ~/ $y = ${x ~/ y}');
  } on FormatException catch (e) {
    print('Format problem: ${e.message}');
  } on UnsupportedError {
    print('Cannot divide by zero');
  } catch (e) {
    print('Something unexpected: $e');
  } finally {
    print('Finished processing "$a" and "$b"');
  }
}

void main() {
  parseAndDivide('10', '2');
  parseAndDivide('ten', '2');
  parseAndDivide('10', '0');
}
