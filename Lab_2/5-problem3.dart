// Problem 3: Dartdoc comments for a data validation utility class specifying parameters, return types, and exceptions.

class Validator {
  static bool isValidEmail(String email) {
    if (email.isEmpty) {
      throw ArgumentError('Email must not be empty');
    }
    final parts = email.split('@');
    return parts.length == 2 &&
        parts[0].isNotEmpty &&
        parts[1].contains('.') &&
        !parts[1].startsWith('.');
  }

  static bool isValidAge(int age, {int min = 0, int max = 120}) {
    return age >= min && age <= max;
  }
}

void main() {
  print(Validator.isValidEmail('user@mail.com'));
  print(Validator.isValidEmail('bad-email'));
  print(Validator.isValidAge(25));
  try {
    Validator.isValidEmail('');
  } on ArgumentError catch (e) {
    print('Caught: $e');
  }
}
