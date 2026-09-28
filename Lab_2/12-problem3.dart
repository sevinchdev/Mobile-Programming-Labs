// Problem 3: throw an ArgumentError if an incoming string parameter is empty or null.

String greet(String? name) {
  if (name == null || name.isEmpty) {
    throw ArgumentError('Name must not be null or empty');
  }
  return 'Hello, $name!';
}

void main() {
  for (final n in <String?>['Alice', '', null]) {
    try {
      print(greet(n));
    } on ArgumentError catch (e) {
      print('ArgumentError: ${e.message}');
    }
  }
}
