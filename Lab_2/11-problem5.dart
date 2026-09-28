// Problem 5: transform stream values using map(), where(), and distinct() operators.

Future<void> main() async {
  final source = Stream<int>.fromIterable([1, 2, 2, 3, 3, 3, 4, 4, 5]);

  final result = source
      .where((n) => n > 1)
      .map((n) => n * 10)
      .distinct();

  await for (final value in result) {
    print(value);
  }
}
