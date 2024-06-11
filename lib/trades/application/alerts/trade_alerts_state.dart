import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stocks_app/trades/domain/entities/trade_alert.dart';

part 'trade_alerts_state.freezed.dart';

@freezed
class TradeAlertsState with _$TradeAlertsState {
  const TradeAlertsState._();

  const factory TradeAlertsState.empty() = _Empty;

  const factory TradeAlertsState.loading() = _Loading;

  const factory TradeAlertsState.data({
    required List<TradeAlert> alerts,
  }) = _Data;

  const factory TradeAlertsState.error() = _Error;
}
