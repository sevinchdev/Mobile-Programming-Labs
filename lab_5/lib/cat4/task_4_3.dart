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


void main(){
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const UserListScreen(),
      '/profile': (context) => const ProfileScreen(),
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
              onTap: () {
                Navigator.pushNamed(
                  context, '/profile',
                  arguments: u,
                );
              },
            ),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)!.settings.arguments as User;
    return Scaffold(
      appBar: AppBar(title: Text(user.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: const Icon(Icons.person),
              title: Text(user.name)
            ),
            ListTile(
              leading: const Icon(Icons.elderly),
              title: Text(user.age.toString()),
            ),
            ListTile(
              leading: const Icon(Icons.location_city),
              title: Text(user.city),
            ),
          ],
        ),
      ),
    );
  }
}