import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/settings',
      name: 'settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/item/:id',
      name: 'item',
      builder: (context, state) => ItemScreen(id: state.pathParameters['id']!),
    ),
  ],
  errorBuilder: (context, state) => const NotFoundScreen(),
);

void main() => runApp(MaterialApp.router(routerConfig: router));

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
              onPressed: () => context.goNamed('settings'),
              child: const Text('Settings'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () =>
                  context.goNamed('item', pathParameters: {'id': '42'}),
              child: const Text('Item 42'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => context.go('/does-not-exist'),
              child: const Text('Open missing page'),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.goNamed('home'),
          child: const Text('Back to home'),
        ),
      ),
    );
  }
}

class ItemScreen extends StatelessWidget {
  final String id;
  const ItemScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Item $id')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.goNamed('home'),
          child: Text('Item #$id - back to home'),
        ),
      ),
    );
  }
}

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('404')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Page not found', style: TextStyle(fontSize: 28)),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => context.goNamed('home'),
              child: const Text('Go home'),
            ),
          ],
        ),
      ),
    );
  }
}