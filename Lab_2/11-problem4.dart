// Problem 4: stream subscriber that listens to periodic timer ticks and cancels after 5 emissions.

import 'dart:async';

Future<void> main() async {
  final done = Completer<void>();
  late StreamSubscription<int> subscription;

  subscription = Stream<int>.periodic(
    const Duration(milliseconds: 500),
    (count) => count + 1,
  ).listen((tick) {
    print('Tick $tick');
    if (tick == 5) {
      subscription.cancel();
      print('Subscription cancelled after 5 ticks');
      done.complete();
    }
  });

  await done.future;
}
