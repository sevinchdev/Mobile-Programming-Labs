import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../models/tick.dart';
import '../services/tick_feed.dart';

/// How many ticks the feed sends before it fails (null = never fail).
final failAfterProvider = StateProvider<int?>((ref) => null);

/// Overridable in tests and in the error demo.
final tickFeedProvider = Provider<TickFeed>((ref) {
  return TickFeed(failAfter: ref.watch(failAfterProvider));
});

final tickerProvider = StreamProvider.autoDispose<List<Tick>>((ref) {
  return ref.watch(tickFeedProvider).watch();
});