// Problem 3: function mapping an enum value to a UI display string using a switch expression.

enum Day { monday, tuesday, wednesday, thursday, friday, saturday, sunday }

String describe(Day day) => switch (day) {
      Day.saturday || Day.sunday => 'Weekend',
      Day.friday => 'Almost weekend',
      _ => 'Work day',
    };

void main() {
  for (final d in [Day.monday, Day.friday, Day.sunday]) {
    print('${d.name}: ${describe(d)}');
  }
}
