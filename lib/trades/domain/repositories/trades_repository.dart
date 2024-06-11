import 'package:dartz/dartz.dart';
import 'package:stocks_app/core/domain/failures/failure.dart';
import 'package:stocks_app/trades/domain/entities/price_update.dart';
import 'package:stocks_app/trades/domain/entities/stock_quote.dart';
import 'package:stocks_app/trades/domain/entities/trade_symbol.dart';

abstract class TradesRepository {
  Future<Either<Failure, List<TradeSymbol>>> searchSymbols({
    required String query,
  });

  Future<Either<Failure, void>> subscribeSymbol(String symbol);

  Future<Either<Failure, void>> unsubscribeSymbol(String symbol);

  Future<Either<Failure, Stream<PriceUpdate>>> getPriceUpdatesStream();

  Future<Either<Failure, Stream<bool>>> getConnectionStatusStream();

  Future<Either<Failure, void>> connectToRealTimeServer();

  Future<Either<Failure, StockQuote>> getStockQuote(String symbol);
}
