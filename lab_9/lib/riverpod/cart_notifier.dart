import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cart.dart';
import '../services/checkout_api.dart';

// T4: the fake server, injected so tests can replace it
final checkoutApiProvider = Provider<CheckoutApi>((ref) => CheckoutApi());

class CartNotifier extends Notifier<CartState> {
  final List<CartState> _history = []; // T5: the undo history

  @override
  CartState build() => const CartState(); // initial state

  // T5: can the Undo button be used?
  bool get canUndo =>
      _history.isNotEmpty && state.status != CheckoutStatus.submitting;

  // T5: a copy of a state without the temporary checkout info
  CartState _snapshot(CartState s) => s.copyWith(
        status: CheckoutStatus.idle,
        orderId: null,
        checkoutError: null,
      );

  /// Every user change goes through here.
  void _apply(CartState Function(CartState) change) {
    final next = change(state);
    if (next != state) _history.add(_snapshot(state)); // T5: only real changes
    state = next; // notifies the watchers (skipped when next == state)
  }

  void add(Product p) =>
      _apply((s) => s.copyWith(lines: s.lines.withProduct(p)));

  void changeQty(String id, int delta) => // T1
      _apply((s) => s.copyWith(lines: s.lines.changeQty(id, delta)));

  void applyCoupon(String code) => _apply((s) => s.withCoupon(code)); // T2

  // T5: go back to the previous state
  void undo() {
    if (!canUndo) return;
    state = _history.removeLast();
  }

  void dismissError() => // T4
      state = state.copyWith(status: CheckoutStatus.idle, checkoutError: null);

  Future<void> checkout() async { // T4
    state = state.copyWith(
      status: CheckoutStatus.submitting,
      orderId: null,
      checkoutError: null,
    );
    try {
      final id = await ref.read(checkoutApiProvider).submit(state.total);
      if (!ref.mounted) return;
      _history.clear(); // T5: an order cannot be undone
      state = const CartState().copyWith(status: CheckoutStatus.success, orderId: id);
    } on CheckoutException catch (e) {
      if (!ref.mounted) return;
      state = state.copyWith(
        status: CheckoutStatus.failure,
        checkoutError: e.message,
      );
    }
  }
}

final cartProvider =
    NotifierProvider<CartNotifier, CartState>(CartNotifier.new);

/// T5: tells the page whether Undo is enabled.
final canUndoProvider = Provider<bool>((ref) {
  ref.watch(cartProvider); // recompute after every state change
  return ref.watch(cartProvider.notifier).canUndo;
});