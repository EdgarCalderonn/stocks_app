enum TradesDataConst {
  searchSymbolsEndpoint('api/v1/search'),
  getStockQuoteEndpoint('api/v1/quote');

  const TradesDataConst(this.value);

  final String value;
}
