import 'package:flutter/material.dart';

class AppRoutes {
  static const home = '/';
  static const profile = '/profile';
  static const messages = '/messages';
  static const about = '/about';
}

void main() {
  runApp(MaterialApp(
    initialRoute: AppRoutes.home,
    routes: {
      AppRoutes.home: (context) => const HomeScreen(),
      AppRoutes.profile: (context) => const SimpleScreen('Profile'),
      AppRoutes.messages: (context) => const SimpleScreen('Messages'),
      AppRoutes.about: (context) => const SimpleScreen('About'),
    },
  ));
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Profile'),
            onTap: () => Navigator.pushNamed(context, AppRoutes.profile),
          ),
          ListTile(
            title: const Text('Messages'),
            onTap: () => Navigator.pushNamed(context, AppRoutes.messages),
          ),
          ListTile(
            title: const Text('About'),
            onTap: () => Navigator.pushNamed(context, AppRoutes.about),
          ),
        ],
      ),
    );
  }
}

class SimpleScreen extends StatelessWidget {
  final String title;
  const SimpleScreen(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text('$title screen')),
    );
  }
}