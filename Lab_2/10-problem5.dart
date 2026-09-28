// Problem 5: Dart 3 sealed classes to construct exhaustive type matching patterns.

sealed class Result {}

class Success extends Result {
  final String data;
  Success(this.data);
}

class Failure extends Result {
  final String error;
  Failure(this.error);
}

class Loading extends Result {}

String show(Result result) => switch (result) {
      Success(:final data) => 'Data: $data',
      Failure(:final error) => 'Error: $error',
      Loading() => 'Loading...',
    };

void main() {
  print(show(Success('42 items')));
  print(show(Failure('No connection')));
  print(show(Loading()));
}
