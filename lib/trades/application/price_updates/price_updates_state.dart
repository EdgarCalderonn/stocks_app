import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stocks_app/trades/domain/entities/price_update.dart';

part 'price_updates_state.freezed.dart';

@freezed
class PriceUpdatesState with _$PriceUpdatesState {
  const PriceUpdatesState._();

  const factory PriceUpdatesState.initial() = _Initial;

  const factory PriceUpdatesState.connecting() = _Connecting;

  const factory PriceUpdatesState.connected({
    required List<PriceUpdate> updates,
    required Map<String, List<PriceUpdate>> updatesHistory,
    required Map<String, PriceUpdate> lastUpdates,
  }) = _Connected;

  const factory PriceUpdatesState.error() = _Error;

  const factory PriceUpdatesState.disconnected() = _Disconnected;
}
