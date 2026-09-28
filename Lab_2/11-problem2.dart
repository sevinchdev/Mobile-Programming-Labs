// Problem 2: async function simulating a database lookup returning user data after a 2-second delay.

Future<Map<String, dynamic>> fetchUserFromDb(int id) async {
  await Future.delayed(const Duration(seconds: 2));
  return {'id': id, 'name': 'Sevinch', 'major': 'Software Engineering'};
}

Future<void> main() async {
  print('Looking up user...');
  final user = await fetchUserFromDb(1);
  print('Found: $user');
}
