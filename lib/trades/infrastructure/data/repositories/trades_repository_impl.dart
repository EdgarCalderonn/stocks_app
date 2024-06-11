import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:stocks_app/core/domain/failures/failure.dart';
import 'package:stocks_app/trades/domain/entities/price_update.dart';
import 'package:stocks_app/trades/domain/entities/stock_quote.dart';
import 'package:stocks_app/trades/domain/entities/trade_symbol.dart';
import 'package:stocks_app/trades/domain/repositories/trades_repository.dart';
import 'package:stocks_app/trades/infrastructure/data/datasources/trades_data_source.dart';
import 'package:stocks_app/trades/infrastructure/mapper/mapper_domain.dart';

@Injectable(as: TradesRepository)
class TradesRepositoryImpl implements TradesRepository {
  const TradesRepositoryImpl(this._tradesDataSource);

  final TradesDataSource _tradesDataSource;

  @override
  Future<Either<Failure, List<TradeSymbol>>> searchSymbols(
      {required String query}) async {
    try {
      final result = await _tradesDataSource.searchSymbols(query);

      return Right(result.toDomain());
    } catch (e) {
      if (kDebugMode) {
        print('ERROR: $e');
      }
      return const Left(Failure.data());
    }
  }

  @override
  Future<Either<Failure, Stream<bool>>> getConnectionStatusStream() {
    // TODO: implement getConnectionStatusStream
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Stream<PriceUpdate>>> getPriceUpdatesStream() async {
    try {
      final stream = await _tradesDataSource.getPriceUpdatesStream();

      return Right(
        stream.map(
          (priceUpdate) => priceUpdate.toDomain(),
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print('ERROR: $e');
      }
      return const Left(Failure.data());
    }
  }

  @override
  Future<Either<Failure, void>> subscribeSymbol(String symbol) async {
    final result = await _tradesDataSource.subscribeToSymbol(symbol);

    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> unsubscribeSymbol(String symbol) {
    // TODO: implement unsubscribeSymbol
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> connectToRealTimeServer() async {
    try {
      await _tradesDataSource.connectToRealTimeServer();

      return const Right(null);
    } catch (e) {
      if (kDebugMode) {
        print('ERROR: $e');
      }
      return const Left(Failure.data());
    }
  }

  @override
  Future<Either<Failure, StockQuote>> getStockQuote(String symbol) async {
    try {
      final result = await _tradesDataSource.getStockQuote(symbol);

      return Right(result.toDomain());
    } catch (e) {
      if (kDebugMode) {
        print('ERROR: $e');
      }
      return const Left(Failure.data());
    }
  }
}
