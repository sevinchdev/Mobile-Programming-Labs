import 'package:flutter/material.dart';
import '../models/cart.dart';
import '../services/checkout_api.dart';
import '../widgets/cart_body.dart';
import '../widgets/cart_extras.dart';

class SetStateCartPage extends StatefulWidget {
  const SetStateCartPage({super.key});

  @override
  State<SetStateCartPage> createState() => _SetStateCartPageState();
}

class _SetStateCartPageState extends State<SetStateCartPage> {
  final _api = CheckoutApi();
  CartState _state = const CartState(); // 1. state is a field on the State object
  final List<CartState> _history = []; // for undo (T5)

  bool get _canUndo =>
      _history.isNotEmpty && _state.status != CheckoutStatus.submitting;

  /// Every user mutation goes through here: remember the old state, then replace it.
  void _apply(CartState Function(CartState) change) {
    setState(() {
      // History keeps the cart without the transient checkout info.
      _history.add(_state.copyWith(
        status: CheckoutStatus.idle,
        orderId: null,
        checkoutError: null,
      ));
      _state = change(_state);
    });
  }

  void _add(Product p) =>
      _apply((s) => s.copyWith(lines: s.lines.withProduct(p)));

  void _changeQty(String id, int delta) =>
      _apply((s) => s.copyWith(lines: s.lines.changeQty(id, delta)));

  void _applyCoupon(String code) => _apply((s) => s.withCoupon(code));

  void _undo() {
    if (!_canUndo) return;
    setState(() => _state = _history.removeLast());
  }

  void _dismissError() => setState(() {
        _state = _state.copyWith(status: CheckoutStatus.idle, checkoutError: null);
      });

  Future<void> _checkout() async {
    setState(() {
      _state = _state.copyWith(
        status: CheckoutStatus.submitting,
        orderId: null,
        checkoutError: null,
      );
    });
    try {
      final id = await _api.submit(_state.total);
      if (!mounted) return; // the page may have been closed during the await
      _history.clear(); // an order cannot be undone
      setState(() {
        _state = const CartState().copyWith(status: CheckoutStatus.success, orderId: id);
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Order $id placed')));
    } on CheckoutException catch (e) {
      if (!mounted) return;
      setState(() {
        _state = _state.copyWith(
          status: CheckoutStatus.failure,
          checkoutError: e.message,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Cart · setState'),
          actions: [
            IconButton(
              tooltip: 'Undo',
              icon: const Icon(Icons.undo),
              onPressed: _canUndo ? _undo : null,
            ),
          ],
        ),
        body: Column(children: [
          if (_state.status == CheckoutStatus.failure)
            MaterialBanner(
              content: Text(_state.checkoutError ?? 'Checkout failed'),
              actions: [
                TextButton(onPressed: _dismissError, child: const Text('Dismiss')),
              ],
            ),
          Expanded(
            child: CartBody(
              lines: _state.lines,
              onAdd: _add,
              onQtyChanged: _changeQty,
            ),
          ),
          CouponField(errorText: _state.couponError, onApply: _applyCoupon),
          SummaryCard(state: _state),
          CheckoutButton(
            submitting: _state.status == CheckoutStatus.submitting,
            enabled: _state.lines.isNotEmpty,
            onPressed: _checkout,
          ),
        ]),
      );
}