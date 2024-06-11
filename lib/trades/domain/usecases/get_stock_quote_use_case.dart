import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:stocks_app/core/domain/failures/failure.dart';
import 'package:stocks_app/core/usecases/use_case.dart';
import 'package:stocks_app/trades/domain/entities/stock_quote.dart';
import 'package:stocks_app/trades/domain/repositories/trades_repository.dart';

@injectable
class GetStockQuoteUseCase extends UseCase<Failure, StockQuote, String> {
  /// Constructor
  GetStockQuoteUseCase(this._tradesRepository);

  final TradesRepository _tradesRepository;

  @override
  Future<Either<Failure, StockQuote>> execute(
    /// symbol
    String params,
  ) async {
    return _tradesRepository.getStockQuote(params);
  }
}
