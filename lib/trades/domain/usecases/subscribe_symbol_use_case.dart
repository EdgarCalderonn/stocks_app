import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:stocks_app/core/domain/failures/failure.dart';
import 'package:stocks_app/core/usecases/use_case.dart';
import 'package:stocks_app/trades/domain/repositories/trades_repository.dart';

@injectable
class SubscribeSymbolUseCase extends UseCase<Failure, void, String> {
  /// Constructor
  SubscribeSymbolUseCase(this._tradesRepository);

  final TradesRepository _tradesRepository;

  @override
  Future<Either<Failure, void>> execute(String params) async {
    return _tradesRepository.subscribeSymbol(params);
  }
}
