// lib/setstate/cart_page_setstate.dart
import 'package:flutter/material.dart';

class SetStateCartPage extends StatelessWidget {
  const SetStateCartPage({super.key});
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text('setState')));
}

// lib/riverpod/cart_page_riverpod.dart  -> class RiverpodCartPage (same shape, text 'Riverpod')
// lib/cubit/cart_page_cubit.dart        -> class CubitCartPage    (same shape, text 'Cubit')
// lib/bloc/cart_page_bloc.dart          -> class BlocCartPage     (same shape, text 'Bloc')