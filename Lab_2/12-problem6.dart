// Problem 6: exception rethrow mechanism using the rethrow keyword.

void process(String value) {
  try {
    int number = int.parse(value);
    print('Parsed: $number');
  } on FormatException catch (e) {
    print('process() logging the error: ${e.message}');
    rethrow;
  }
}

void main() {
  try {
    process('42');
    process('abc');
  } on FormatException {
    print('main() caught the rethrown exception');
  }
}
