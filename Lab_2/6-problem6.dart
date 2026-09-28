// Problem 6: immutable data transfer class using const constructors and final field modifiers.

class UserDto {
  final String name;
  final int age;

  const UserDto(this.name, this.age);

  UserDto copyWith({String? name, int? age}) {
    return UserDto(name ?? this.name, age ?? this.age);
  }

  @override
  String toString() => 'UserDto(name: $name, age: $age)';
}

void main() {
  const a = UserDto('Ali', 20);
  const b = UserDto('Ali', 20);
  print('Same const object: ${identical(a, b)}');

  var older = a.copyWith(age: 21);
  print(a);
  print(older);
}
