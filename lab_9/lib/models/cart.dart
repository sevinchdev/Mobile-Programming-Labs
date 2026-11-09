class Product {
  const Product({required this.id, required this.name, required this.price});
  final String id;
  final String name;
  final double price;
}

const catalog = [
  Product(id: 'p1', name: 'Keyboard', price: 49),
  Product(id: 'p2', name: 'Mouse', price: 25),
  Product(id: 'p3', name: 'Monitor', price: 199),
];

class CartLine {
  const CartLine({required this.product, required this.qty});
  final Product product;
  final int qty;

  double get subtotal => product.price * qty;

  CartLine copyWith({int? qty}) =>
      CartLine(product: product, qty: qty ?? this.qty);
}

/// Pure, style-independent cart logic. Every state holder calls these.
extension CartLines on List<CartLine> {
  List<CartLine> withProduct(Product p) {
    final i = indexWhere((l) => l.product.id == p.id);
    if (i == -1) return [...this, CartLine(product: p, qty: 1)];
    return [
      for (final l in this)
        l.product.id == p.id ? l.copyWith(qty: l.qty + 1) : l,
    ];
  }

  List<CartLine> without(String productId) =>
      [for (final l in this) if (l.product.id != productId) l];

  double get subtotal => fold(0, (s, l) => s + l.subtotal);
  int get itemCount => fold(0, (s, l) => s + l.qty);

    /// Changes a line's quantity. If it would reach 0, the line is removed.
  List<CartLine> changeQty(String productId, int delta) => [
        for (final l in this)
          if (l.product.id != productId)
            l
          else if (l.qty + delta > 0)
            l.copyWith(qty: l.qty + delta),
  ];
}

enum CheckoutStatus { idle, submitting, success, failure }

const _unset = Object();

class CartState {
  const CartState({
    this.lines = const [],
    this.coupon,
    this.couponError,
    this.status = CheckoutStatus.idle,
    this.orderId,
    this.checkoutError,
  });

  final List<CartLine> lines;
  final String? coupon;
  final String? couponError;
  final CheckoutStatus status;
  final String? orderId;
  final String? checkoutError;

  // Derived values: computed on every read, never stored (T3).
  int get itemCount => lines.itemCount;
  double get subtotal => lines.subtotal;
  double get discount => coupon == 'SAVE10' ? subtotal * 0.10 : 0.0;
  double get total => subtotal - discount;

  CartState copyWith({
    List<CartLine>? lines,
    Object? coupon = _unset,
    Object? couponError = _unset,
    CheckoutStatus? status,
    Object? orderId = _unset,
    Object? checkoutError = _unset,
  }) {
    return CartState(
      lines: lines ?? this.lines,
      coupon: identical(coupon, _unset) ? this.coupon : coupon as String?,
      couponError:
          identical(couponError, _unset) ? this.couponError : couponError as String?,
      status: status ?? this.status,
      orderId: identical(orderId, _unset) ? this.orderId : orderId as String?,
      checkoutError: identical(checkoutError, _unset)
          ? this.checkoutError
          : checkoutError as String?,
    );
  }

  /// Pure coupon rule: SAVE10 is valid, anything else sets an error.
  CartState withCoupon(String code) {
    if (code.trim().toUpperCase() == 'SAVE10') {
      return copyWith(coupon: 'SAVE10', couponError: null);
    }
    return copyWith(couponError: 'Invalid coupon code');
  }
}