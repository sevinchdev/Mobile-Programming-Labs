import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lab_5/cat3/task_3_1.dart';
import 'package:lab_5/cat5/task_5_1.dart';

final router = GoRouter(
  initialLocation: '/',

  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomeScreen()),
    GoRoute(
      path: '/product/:id',
      builder:(context, state) => ProductScreen(id: state.pathParameters['id']!),
      ),
  ],
);

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
            for (final n in [1,2,3])
              Padding(
                padding: const EdgeInsets.all(6),
                child: ElevatedButton(
              onPressed: () => context.push('/product/$n'),
              child: Text('Product $n'),
            ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductScreen extends StatelessWidget {
  final String id;
  const ProductScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product #$id')),
      body: Center(
        child: Text('Product #$id', style: const TextStyle(fontSize: 28)),
      ),
    );
  }
}