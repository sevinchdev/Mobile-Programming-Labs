// Problem 3: Future.wait() to run three asynchronous tasks concurrently and aggregate their results.

Future<String> task(String name, int seconds) async {
  await Future.delayed(Duration(seconds: seconds));
  return '$name finished after ${seconds}s';
}

Future<void> main() async {
  final watch = Stopwatch()..start();
  final results = await Future.wait([
    task('A', 1),
    task('B', 2),
    task('C', 3),
  ]);
  print(results);
  print('Total time: about ${watch.elapsed.inSeconds}s');
}
