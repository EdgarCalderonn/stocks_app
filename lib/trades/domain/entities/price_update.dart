class PriceUpdate {
  final String symbol;
  final double lastPrice;
  final int timeStamp;
  final double volume;

  PriceUpdate({
    required this.symbol,
    required this.lastPrice,
    required this.timeStamp,
    required this.volume,
  });
}
