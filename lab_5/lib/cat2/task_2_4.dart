import 'package:flutter/material.dart';

class AppRoutes{
  static const home = '/';
  static const profile = '/profile';
  static const messages = '/messages';
  static const about = '/about';
}

void main() {
  runApp(MaterialApp(
    initialRoute: AppRoutes.home,
    routes: {
      AppRoutes.home: (context) => const SectionScreen('Home'),
      AppRoutes.profile: (context) => const SectionScreen('Profile'),
      AppRoutes.messages: (context) => const SectionScreen('Messages'),
      AppRoutes.about: (context) => const SectionScreen('About'),
    },
  ));
}

class AppDrawer extends StatelessWidget{
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context){
    const items = {
      'Home': AppRoutes.home,
      'Profile': AppRoutes.profile,
      'Messages': AppRoutes.messages,
      'About': AppRoutes.about,
    };

    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(child: Text('Menu', style: TextStyle(fontSize: 24))),
          for (final e in items.entries)
            ListTile(
              title: Text(e.key),
              onTap: () {
                Navigator.pop(context); // close the drawer
                Navigator.pushReplacementNamed(context, e.value);
              },
            ),
        ],
      ),
    );
  }
}

class SectionScreen extends StatelessWidget {
  final String title;
  const SectionScreen(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      drawer: const AppDrawer(),
      body: Center(child: Text('$title screen', style: const TextStyle(fontSize: 28))),
    );
  }
}