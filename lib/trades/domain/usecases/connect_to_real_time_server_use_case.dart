import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:stocks_app/core/domain/failures/failure.dart';
import 'package:stocks_app/core/usecases/use_case.dart';
import 'package:stocks_app/trades/domain/repositories/trades_repository.dart';

@injectable
class ConnectToRealTimeServerUseCase extends UseCase<Failure, void, void> {
  /// Constructor
  ConnectToRealTimeServerUseCase(this._tradesRepository);

  final TradesRepository _tradesRepository;

  @override
  Future<Either<Failure, void>> execute(void params) async {
    return _tradesRepository.connectToRealTimeServer();
  }
}
