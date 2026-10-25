import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'models/tick.dart';
import 'providers/ticker_provider.dart';
import 'widgets/tick_row.dart';

class TickerPage extends ConsumerWidget {
  const TickerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ticks = ref.watch(tickerProvider);

    Widget rows(List<Tick> list) => ListView(
          children: [for (final t in list) TickRow(t, key: ValueKey(t.symbol))],
        );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Live ticker'),
        actions: [
          IconButton(
            tooltip: 'Make the feed fail after 5 ticks',
            icon: const Icon(Icons.bug_report),
            onPressed: () => ref.read(failAfterProvider.notifier).state = 5,
          ),
          IconButton(
            tooltip: 'Restore the feed',
            icon: const Icon(Icons.wifi),
            onPressed: () => ref.read(failAfterProvider.notifier).state = null,
          ),
        ],
      ),
      body: switch (ticks) {
        // Error, but old prices exist: dim them and show a banner
        AsyncError(:final error, :final value?) => Column(children: [
            MaterialBanner(
              content: Text('Feed error: $error - showing last prices'),
              actions: [
                TextButton(
                  onPressed: () => ref.invalidate(tickerProvider),
                  child: const Text('Retry'),
                ),
              ],
            ),
            Expanded(child: Opacity(opacity: 0.5, child: rows(value))),
          ]),
        // Error and nothing to show
        AsyncError(:final error) => Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Text('Could not load ticker\n$error', textAlign: TextAlign.center),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () => ref.invalidate(tickerProvider),
                child: const Text('Retry'),
              ),
            ]),
          ),
        // Reloading, but old prices exist: keep them and show a thin bar
        AsyncValue(:final value?, isLoading: true) => Column(children: [
            const LinearProgressIndicator(),
            Expanded(child: rows(value)),
          ]),
        AsyncData(value: []) => const Center(child: Text('No symbols subscribed')),
        AsyncData(value: [final only]) => Center(child: TickRow(only)),
        AsyncData(:final value) => rows(value),
        // First load only
        AsyncLoading() => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}