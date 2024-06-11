import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:stocks_app/core/domain/failures/failure.dart';
import 'package:stocks_app/core/usecases/use_case.dart';
import 'package:stocks_app/trades/domain/entities/price_update.dart';
import 'package:stocks_app/trades/domain/repositories/trades_repository.dart';

@injectable
class GetPriceUpdatesStreamUseCase
    extends UseCase<Failure, Stream<PriceUpdate>, void> {
  /// Constructor
  GetPriceUpdatesStreamUseCase(this._tradesRepository);

  final TradesRepository _tradesRepository;

  @override
  Future<Either<Failure, Stream<PriceUpdate>>> execute(
    /// symbol
    void params,
  ) async {
    return _tradesRepository.getPriceUpdatesStream();
  }
}
