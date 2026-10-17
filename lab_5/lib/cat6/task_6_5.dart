import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

CustomTransitionPage<void> buildPage(GoRouterState state, Widget child) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    transitionDuration: const Duration(milliseconds: 400),
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(parent: animation, curve: Curves.easeOut);
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(curved),
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.9, end: 1.0).animate(curved),
          child: child,
        ),
      );
    },
  );
}

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => buildPage(state, const HomeScreen()),
    ),
    GoRoute(
      path: '/details',
      pageBuilder: (context, state) => buildPage(state, const DetailsScreen()),
    ),
    GoRoute(
      path: '/about',
      pageBuilder: (context, state) => buildPage(state, const AboutScreen()),
    ),
  ],
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
              onPressed: () => context.push('/details'),
              child: const Text('Details'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => context.push('/about'),
              child: const Text('About'),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Details')),
      body: const Center(child: Text('Slide + scale!')),
    );
  }
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: const Center(child: Text('Same helper, same transition')),
    );
  }
}