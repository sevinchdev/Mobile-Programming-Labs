import 'package:flutter/material.dart';
import '../models/cart.dart';

/// Text field + Apply button. Knows nothing about state management.
class CouponField extends StatefulWidget {
  const CouponField({super.key, required this.errorText, required this.onApply});

  final String? errorText;
  final void Function(String code) onApply;

  @override
  State<CouponField> createState() => _CouponFieldState();
}

class _CouponFieldState extends State<CouponField> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Row(children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Coupon code',
                errorText: widget.errorText, // shown in red under the field
                border: const OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(width: 8),
          FilledButton(
            onPressed: () => widget.onApply(_controller.text),
            child: const Text('Apply'),
          ),
        ]),
      );
}

/// Item count, subtotal, discount and total (T3).
class SummaryCard extends StatelessWidget {
  const SummaryCard({super.key, required this.state});

  final CartState state;

  Widget _row(String label, String value, {bool bold = false}) {
    final style = bold ? const TextStyle(fontWeight: FontWeight.bold) : null;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(label, style: style), Text(value, style: style)],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Card(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(children: [
            _row('Items', '${state.itemCount}'),
            _row('Subtotal', state.subtotal.toStringAsFixed(2)),
            _row('Discount', '-${state.discount.toStringAsFixed(2)}'),
            _row('Total', state.total.toStringAsFixed(2), bold: true),
          ]),
        ),
      );
}

/// Checkout button with a spinner while submitting (T4).
class CheckoutButton extends StatelessWidget {
  const CheckoutButton({
    super.key,
    required this.submitting,
    required this.enabled,
    required this.onPressed,
  });

  final bool submitting;
  final bool enabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(12),
        child: SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: (submitting || !enabled) ? null : onPressed,
            child: submitting
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Checkout'),
          ),
        ),
      );
}