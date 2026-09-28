// Problem 6: error handling on an asynchronous stream pipeline using handleError callbacks.

import 'dart:async';

Future<void> main() async {
  final controller = StreamController<int>();

  controller.stream
      .handleError((error) => print('Handled error: $error'))
      .listen(
        (value) => print('Value: $value'),
        onDone: () => print('Stream closed'),
      );

  controller.add(1);
  controller.addError(Exception('Something went wrong'));
  controller.add(2);
  controller.addError(Exception('Another failure'));
  controller.add(3);

  await controller.close();
}
