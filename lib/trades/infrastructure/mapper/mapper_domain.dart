import 'package:stocks_app/trades/domain/entities/price_update.dart';
import 'package:stocks_app/trades/domain/entities/stock_quote.dart';
import 'package:stocks_app/trades/domain/entities/trade_symbol.dart';
import 'package:stocks_app/trades/infrastructure/data/dtos/price_update_dto.dart';
import 'package:stocks_app/trades/infrastructure/data/dtos/stock_quote_dto.dart';
import 'package:stocks_app/trades/infrastructure/data/dtos/trade_symbol_dto.dart';

extension MapperTradeSymbolDTO on TradeSymbolDTO {
  /// [TradeSymbolDTO] (Infrastructure) to [TradeSymbol] (Domain)
  TradeSymbol toDomain() => TradeSymbol(
        description: description,
        displaySymbol: displaySymbol,
        symbol: symbol,
        type: type,
      );
}

extension MapperListTradeSymbolDTO on List<TradeSymbolDTO> {
  List<TradeSymbol> toDomain() =>
      map<TradeSymbol>((e) => e.toDomain()).toList();
}

extension MapperStockQuoteDTO on StockQuoteDTO {
  /// [StockQuoteDTO] (Infrastructure) to [StockQuote] (Domain)
  StockQuote toDomain() => StockQuote(
        change: change ?? 0,
        currentPrice: currentPrice,
        highPriceOfTheDay: highPriceOfTheDay,
        lowPriceOfTheDay: lowPriceOfTheDay,
        openPriceOfTheDay: openPriceOfTheDay,
        percentChange: percentChange ?? 0,
        previousClosePrice: previousClosePrice,
      );
}

extension MapperPriceUpdateDTO on PriceUpdateDTO {
  /// [PriceUpdateDTO] (Infrastructure) to [PriceUpdate] (Domain)
  PriceUpdate toDomain() => PriceUpdate(
        lastPrice: lastPrice,
        symbol: symbol,
        timeStamp: timeStamp,
        volume: volume,
      );
}
