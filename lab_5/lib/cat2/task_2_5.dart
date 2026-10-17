import 'package:flutter/material.dart';
import 'package:lab_5/cat6/task_6_2.dart';

class AppRoutes{
  static const home = '/home';
  static const login = '/login';
  static const profile = '/profile';
}

void main() {
  runApp(MaterialApp(
    initialRoute: AppRoutes.login,
    routes: {
      AppRoutes.home: (context) => const HomeScreen(),
      AppRoutes.login: (context) => const LoginScreen(),
      AppRoutes.profile: (context) => const ProfileScreen(),
    },
  ));
}

class LoginScreen extends StatelessWidget{
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: ElevatedButton(
          child: const Text('Sign in'),
          onPressed: () =>
              Navigator.pushReplacementNamed(context, AppRoutes.home),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: ElevatedButton(
          child: const Text('Open profile'),
          onPressed: () => Navigator.pushNamed(context, AppRoutes.profile),
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: ElevatedButton(
          child: const Text('Log out'),
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.login,
            (route) => false,
          ),
        ),
      ),
    );
  }
}