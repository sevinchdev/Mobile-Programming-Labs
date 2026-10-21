class Tick{
  const Tick({
    required this.symbol,
    required this.price,
    required this.change,
    required this.time
  });

  final String symbol;
  final double price;
  final double change;
  final DateTime time;

  bool get isUp => change >= 0;
}