import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'bloc/cart_page_bloc.dart';
// import 'cubit/cart_page_cubit.dart';
// import 'riverpod/cart_page_riverpod.dart';
import 'setstate/cart_page_setstate.dart';

void main() => runApp(const ProviderScope(child: CartApp()));

class CartApp extends StatelessWidget {
  const CartApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Cart four ways',
        theme: ThemeData(colorSchemeSeed: Colors.teal, useMaterial3: true),
        home: const HomePage(),
      );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => const Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _NavButton('setState', SetStateCartPage()),
              // _NavButton('Riverpod', RiverpodCartPage()),
              // _NavButton('Cubit', CubitCartPage()),
              // _NavButton('Bloc', BlocCartPage()),
            ],
          ),
        ),
      );
}

class _NavButton extends StatelessWidget {
  const _NavButton(this.label, this.page);
  final String label;
  final Widget page;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(6),
        child: FilledButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => page),
          ),
          child: Text(label),
        ),
      );
}