import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stocks_app/trades/application/alerts/trade_alerts_state.dart';
import 'package:stocks_app/trades/domain/entities/trade_alert.dart';
import 'package:stocks_app/trades/domain/entities/trade_symbol.dart';
import 'package:stocks_app/trades/domain/usecases/get_stock_quote_use_case.dart';

class TradeAlertsNotifier extends StateNotifier<TradeAlertsState> {
  TradeAlertsNotifier(
    this._getStockQuoteUseCase,
  ) : super(const TradeAlertsState.empty());

  final GetStockQuoteUseCase _getStockQuoteUseCase;

  void addTradeAlert(TradeSymbol symbol, double alertPrice) async {
    final initialState = state;

    state = const TradeAlertsState.loading();
    final result = await _getStockQuoteUseCase.execute(symbol.symbol);

    state = result.fold(
      (l) => initialState,
      (r) {
        return initialState.maybeWhen(
          data: (alerts) => TradeAlertsState.data(alerts: [
            ...alerts,
            TradeAlert(
              tradeSymbol: symbol,
              priceValue: alertPrice,
              initialStockQuote: r,
            ),
          ]),
          orElse: () => TradeAlertsState.data(alerts: [
            TradeAlert(
              tradeSymbol: symbol,
              priceValue: alertPrice,
              initialStockQuote: r,
            ),
          ]),
        );
      },
    );
  }
}
