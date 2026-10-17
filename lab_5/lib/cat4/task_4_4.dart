import 'package:flutter/material.dart';

class User {
  final String name;
  final int age;
  final String city;
  const User(this.name, this.age, this.city);
}

const users = [
  User('Alice', 21, 'Tashkent'),
  User('Bob', 25, 'Samarkand'),
  User('Carol', 19, 'Bukhara'),
  User('David', 30, 'Namangan'),
];

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    onGenerateRoute: (settings) {
      if (settings.name == '/') {
        return MaterialPageRoute(builder: (c) => const UserListScreen());
      }
      if (settings.name == '/profile') {
        final args = settings.arguments;
        if (args is User) {
          return MaterialPageRoute(builder: (c) => ProfileScreen(user: args));
        }
      }
      return null;
    },
  ));
}

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Users')),
      body: ListView(
        children: [
          for (final u in users)
            ListTile(
              leading: CircleAvatar(child: Text(u.name[0])),
              title: Text(u.name),
              onTap: () =>
                  Navigator.pushNamed(context, '/profile', arguments: u),
            ),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  final User user;
  const ProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(user.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(user.name),
                ),
                ListTile(
                  leading: const Icon(Icons.cake),
                  title: Text('${user.age} years old'),
                ),
                ListTile(
                  leading: const Icon(Icons.location_city),
                  title: Text(user.city),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}