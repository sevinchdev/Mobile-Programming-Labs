// Problem 5: parse raw string data safely into enum values using Enum.values.byName().

enum Day { monday, tuesday, wednesday, thursday, friday, saturday, sunday }

Day? parseDay(String raw) {
  try {
    return Day.values.byName(raw.toLowerCase());
  } on ArgumentError {
    return null;
  }
}

void main() {
  for (final raw in ['Monday', 'sunday', 'funday']) {
    final parsed = parseDay(raw);
    print(parsed == null ? '"$raw" is not a valid day' : '"$raw" -> $parsed');
  }
}
