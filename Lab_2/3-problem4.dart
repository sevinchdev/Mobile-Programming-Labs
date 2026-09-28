// Problem 4: while loop simulating a guess-the-number game that breaks upon reaching the target value.

void main() {
  const int target = 7;
  final List<int> guesses = [3, 10, 5, 7, 9];
  int attempts = 0;
  int index = 0;

  while (index < guesses.length) {
    int guess = guesses[index++];
    attempts++;
    print('Guess #$attempts: $guess');
    if (guess == target) {
      print('Correct! Found $target in $attempts attempts.');
      break;
    }
    print(guess < target ? 'Too low' : 'Too high');
  }
}
