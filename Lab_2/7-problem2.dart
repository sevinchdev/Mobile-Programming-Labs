// Problem 2: basic enum Day containing days of the week, iterating over all values using Day.values.

enum Day { monday, tuesday, wednesday, thursday, friday, saturday, sunday }

void main() {
  for (final d in Day.values) {
    print('${d.index}: ${d.name}');
  }
}
