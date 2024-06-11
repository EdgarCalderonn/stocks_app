import 'package:dartz/dartz.dart';

/// Use case with params
abstract class UseCase<T, Type, Params> {
  Future<Either<T, Type>> execute(Params params);
}
