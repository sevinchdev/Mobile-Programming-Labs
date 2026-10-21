import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/ticker_provider.dart';

class TickerPage extends ConsumerWidget {
  const TickerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(tickerProvider, (_, next) => debugPrint('$next'));
    return const Scaffold(
      body: Center(child: Text('Ticker')),
    );
  }
}