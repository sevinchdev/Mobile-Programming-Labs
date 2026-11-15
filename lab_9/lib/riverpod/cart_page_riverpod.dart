import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cart.dart';
import '../widgets/cart_body.dart';
import '../widgets/cart_extras.dart';
import 'cart_notifier.dart';

/// T3: rebuilds only when one of the four displayed numbers changes.
class RiverpodSummary extends ConsumerWidget {
  const RiverpodSummary({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('RiverpodSummary rebuilt'); // T3: proof of the selective rebuild
    final (items, subtotal, discount, total) = ref.watch(
      cartProvider.select(
        (s) => (s.itemCount, s.subtotal, s.discount, s.total),
      ),
    );
    return SummaryValues(
      itemCount: items,
      subtotal: subtotal,
      discount: discount,
      total: total,
    );
  }
}

class RiverpodCartPage extends ConsumerWidget {
  const RiverpodCartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lines = ref.watch(cartProvider.select((s) => s.lines));
    final couponError = ref.watch(cartProvider.select((s) => s.couponError)); // T2
    final status = ref.watch(cartProvider.select((s) => s.status)); // T4
    final checkoutError = ref.watch(cartProvider.select((s) => s.checkoutError)); // T4
    final canUndo = ref.watch(canUndoProvider); // T5: rebuilds when Undo changes
    final cart = ref.read(cartProvider.notifier);

    // T4: the snackbar is a side effect, so it lives in listen
    ref.listen(cartProvider.select((s) => s.status), (prev, next) {
      if (next == CheckoutStatus.success) {
        final id = ref.read(cartProvider).orderId;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Order $id placed')));
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart · Riverpod'),
        actions: [
          IconButton( // T5: the Undo button
            tooltip: 'Undo',
            icon: const Icon(Icons.undo),
            onPressed: canUndo ? cart.undo : null, // null = disabled
          ),
        ],
      ),
      body: Column(children: [
        if (status == CheckoutStatus.failure) // T4: the failure banner
          MaterialBanner(
            content: Text(checkoutError ?? 'Checkout failed'),
            actions: [
              TextButton(onPressed: cart.dismissError, child: const Text('Dismiss')),
            ],
          ),
        Expanded(
          child: CartBody(
            lines: lines,
            onAdd: cart.add,
            onQtyChanged: cart.changeQty, // T1
          ),
        ),
        CouponField(errorText: couponError, onApply: cart.applyCoupon), // T2
        const RiverpodSummary(), // T3
        CheckoutButton( // T4
          submitting: status == CheckoutStatus.submitting,
          enabled: lines.isNotEmpty,
          onPressed: cart.checkout,
        ),
      ]),
    );
  }
}