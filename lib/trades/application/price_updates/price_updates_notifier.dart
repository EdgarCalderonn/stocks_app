import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stocks_app/trades/application/price_updates/price_updates_state.dart';
import 'package:stocks_app/trades/domain/entities/price_update.dart';
import 'package:stocks_app/trades/domain/usecases/connect_to_real_time_server_use_case.dart';
import 'package:stocks_app/trades/domain/usecases/get_price_updates_stream_use_case.dart';
import 'package:stocks_app/trades/domain/usecases/subscribe_symbol_use_case.dart';

class PriceUpdatesNotifier extends StateNotifier<PriceUpdatesState> {
  PriceUpdatesNotifier(
    this._connectToRealTimeServerUseCase,
    this._subscribeSymbolUseCase,
    this._getPriceUpdatesStreamUseCase,
  ) : super(const PriceUpdatesState.initial());

  final ConnectToRealTimeServerUseCase _connectToRealTimeServerUseCase;
  final SubscribeSymbolUseCase _subscribeSymbolUseCase;
  final GetPriceUpdatesStreamUseCase _getPriceUpdatesStreamUseCase;

  StreamSubscription? subscription;

  final Map<String, List<PriceUpdate>> _updatesHistory = {};
  final Map<String, PriceUpdate> _lastUpdates = {};

  Future connect() async {
    final result = await _connectToRealTimeServerUseCase.execute(null);

    result.fold(
      (l) => const PriceUpdatesState.error(),
      (_) async {
        final streamResult = await _getPriceUpdatesStreamUseCase.execute(null);

        streamResult.fold(
          (l) => const PriceUpdatesState.error(),
          (stream) {
            subscription ??= stream.listen((PriceUpdate update) {
              /// Update the history with the new value
              if (_updatesHistory.containsKey(update.symbol)) {
                _updatesHistory[update.symbol]!.add(update);
              } else {
                _updatesHistory[update.symbol] = [update];
              }

              /// Update the lastUpdate map with the last value for this symbol
              _lastUpdates[update.symbol] = update;
              state = PriceUpdatesState.connected(
                updates: [],
                updatesHistory: _updatesHistory,
                lastUpdates: _lastUpdates,
              );
            });
          },
        );
      },
    );
  }

  bool isUpdatedSymbol(String symbol) {
    if (_lastUpdates.containsKey(symbol)) {
      return true;
    }
    return false;
  }

  PriceUpdate? getLastUpdate(String symbol) {
    return _lastUpdates[symbol];
  }

  List<PriceUpdate> getUpdatesOfSymbol(String symbol) {
    return _updatesHistory[symbol] ?? [];
  }

  Future subscribeSymbol(String symbol) async {
    _subscribeSymbolUseCase.execute(symbol);
  }

  double getPercentage(double initialPrice, double currentPrice) {
    return ((currentPrice - initialPrice) / initialPrice) * 100;
  }
}
