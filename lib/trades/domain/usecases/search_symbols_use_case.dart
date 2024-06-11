import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:stocks_app/core/domain/failures/failure.dart';
import 'package:stocks_app/core/usecases/use_case.dart';
import 'package:stocks_app/trades/domain/entities/trade_symbol.dart';
import 'package:stocks_app/trades/domain/repositories/trades_repository.dart';

@injectable
class SearchSymbolsUseCase extends UseCase<Failure, List<TradeSymbol>, String> {
  /// Constructor
  SearchSymbolsUseCase(this._tradesRepository);

  final TradesRepository _tradesRepository;

  @override
  Future<Either<Failure, List<TradeSymbol>>> execute(
    /// id
    String params,
  ) async {
    return _tradesRepository.searchSymbols(query: params);
  }
}
