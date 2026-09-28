// Problem 7: state-machine transition manager driven completely by enhanced enum logic.

enum OrderState {
  created,
  paid,
  shipped,
  delivered;

  OrderState? get next => switch (this) {
        OrderState.created => OrderState.paid,
        OrderState.paid => OrderState.shipped,
        OrderState.shipped => OrderState.delivered,
        OrderState.delivered => null,
      };

  bool canMoveTo(OrderState target) => next == target;
}

void main() {
  var state = OrderState.created;
  print('Start: ${state.name}');

  while (state.next != null) {
    final target = state.next!;
    print('${state.name} -> ${target.name} allowed: ${state.canMoveTo(target)}');
    state = target;
  }

  print('Final: ${state.name}');
  print('created -> delivered allowed: ${OrderState.created.canMoveTo(OrderState.delivered)}');
}
