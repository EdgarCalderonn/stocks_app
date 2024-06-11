import 'package:stocks_app/trades/domain/entities/price_update.dart';
import 'package:stocks_app/trades/domain/entities/stock_quote.dart';
import 'package:stocks_app/trades/domain/entities/trade_symbol.dart';

class TradeAlert {
  final TradeSymbol tradeSymbol;
  final double priceValue;
  final StockQuote initialStockQuote;
  final List<PriceUpdate> updates;

  String get symbolId => tradeSymbol.symbol;

  const TradeAlert({
    required this.tradeSymbol,
    required this.priceValue,
    required this.initialStockQuote,
    this.updates = const [],
  });
}
