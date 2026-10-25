# Lab 6 - Real-Time Data Ticker with AsyncValue

## Part 1 - Setup

Created the project `riverpod_ticker` and added `flutter_riverpod`. `main()` wraps the
app in `ProviderScope`, which is the container that stores the state of every provider;
without it, `ref.watch` has nothing to read from. `TickerPage` is a stub
`ConsumerWidget` (a placeholder screen) so the app compiles and runs.

## Part 2 - Model and provider

**Q1. Why is the feed behind its own Provider instead of being constructed inside tickerProvider?**

So it can be replaced from outside without editing `tickerProvider`. In tests,
`tickFeedProvider.overrideWithValue(TickFeed(failAfter: 1))` swaps in a feed that fails
on purpose or has other symbols, and in the app, a toggle can change how the feed is
built (Part 4). `tickerProvider` gets the feed with `ref.watch`, so it automatically
restarts if the feed changes. If the feed were created inside `tickerProvider`, it would
be hard-wired and impossible to override.

**Q2. What does autoDispose do when the user navigates away mid-stream?**

When no widget is watching the provider any more, `autoDispose` destroys its state and
cancels the stream subscription, so the feed stops producing ticks and no resources are
wasted. When the user returns, the provider is created again from scratch and starts
at the loading state.

**Q3. What AsyncValue does tickerProvider hold during the 800 ms delay, and what is hasValue?**

It holds `AsyncLoading`, because the stream has not emitted anything yet. `hasValue` is
`false` at that moment, since there is no data and no previous data to keep.

## Part 3 - Ticker UI

**Exercise 3.3: removing the AsyncLoading arm**

flutter analyze reports: "The type 'AsyncValue<List<Tick>>' isn't exhaustively matched
by the switch cases since it doesn't match the pattern 'AsyncLoading<List<Tick>>()'.
Try adding a wildcard pattern or cases that match 'AsyncLoading<List<Tick>>()'"
(non_exhaustive_switch_expression).
AsyncValue is a sealed class with three subtypes (AsyncData, AsyncLoading,
AsyncError), so a switch expression over it must cover all of them. The compiler
therefore tells me at compile time if I forget a state.

**Exercise 3.4: why the specific arms go first**

A switch checks the arms from top to bottom and runs the first one that matches.
AsyncData(:final value) matches every AsyncData, including the empty list and the
one-element list, so if it came first the more specific arms below it would never
be reached (the analyzer flags them as unreachable).