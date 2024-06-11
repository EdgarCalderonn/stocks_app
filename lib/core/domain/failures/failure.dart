import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

/// Failures to be handled
@freezed
class Failure with _$Failure {
  const Failure._();

  /// When data sent is wrong
  const factory Failure.data() = _Data;

  /// When occurs an error on server side
  const factory Failure.server() = _Server;

  /// When there is not internet connection
  const factory Failure.noConnection() = _NoConnection;
}
