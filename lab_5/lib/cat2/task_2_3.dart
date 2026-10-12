import 'package:flutter/material.dart';

class AppRoutes {
  static const home = '/';
  static const about = '/about';
}

void main() {
  runApp(MaterialApp(
    initialRoute: AppRoutes.home,
    routes: {
      AppRoutes.home: (context) => const HomeScreen(),
      AppRoutes.about: (context) => const AboutScreen(),
    },
    onUnknownRoute: (settings) => MaterialPageRoute(
      builder: (context) => const NotFoundScreen(),
    ),
  ));
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              child: const Text('About (exists)'),
              onPressed: () => Navigator.pushNamed(context, AppRoutes.about),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              child: const Text('Open missing page'),
              onPressed: () => Navigator.pushNamed(context, '/does-not-exist'),
            ),
          ],
        ),
      ),
    );
  }
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: const Center(child: Text('About screen')),
    );
  }
}

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('404')),
      body: const Center(
        child: Text('Page not found', style: TextStyle(fontSize: 28)),
      ),
    );
  }
}