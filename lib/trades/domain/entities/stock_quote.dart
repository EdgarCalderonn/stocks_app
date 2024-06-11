class StockQuote {
  final double currentPrice;
  final double change;
  final double percentChange;
  final double highPriceOfTheDay;
  final double lowPriceOfTheDay;
  final double openPriceOfTheDay;
  final double previousClosePrice;

  StockQuote({
    required this.currentPrice,
    required this.change,
    required this.percentChange,
    required this.highPriceOfTheDay,
    required this.lowPriceOfTheDay,
    required this.openPriceOfTheDay,
    required this.previousClosePrice,
  });
}
