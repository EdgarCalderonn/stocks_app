import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stocks_app/core/shared/dependency_injection/app_modules.dart';
import 'package:stocks_app/trades/application/alerts/trade_alerts_notifier.dart';
import 'package:stocks_app/trades/application/alerts/trade_alerts_state.dart';
import 'package:stocks_app/trades/application/price_updates/price_updates_notifier.dart';
import 'package:stocks_app/trades/application/price_updates/price_updates_state.dart';
import 'package:stocks_app/trades/application/search_symbols/search_symbols_notifier.dart';
import 'package:stocks_app/trades/application/search_symbols/search_symbols_state.dart';
import 'package:stocks_app/trades/domain/usecases/connect_to_real_time_server_use_case.dart';
import 'package:stocks_app/trades/domain/usecases/get_price_updates_stream_use_case.dart';
import 'package:stocks_app/trades/domain/usecases/get_stock_quote_use_case.dart';
import 'package:stocks_app/trades/domain/usecases/search_symbols_use_case.dart';
import 'package:stocks_app/trades/domain/usecases/subscribe_symbol_use_case.dart';

final searchSymbolsNotifierProvider =
    StateNotifierProvider<SearchSymbolsNotifier, SearchSymbolsState>(
  (ref) => SearchSymbolsNotifier(
    getIt<SearchSymbolsUseCase>(),
  ),
);

final tradeAlertsNotifierProvider =
    StateNotifierProvider<TradeAlertsNotifier, TradeAlertsState>(
  (ref) => TradeAlertsNotifier(getIt<GetStockQuoteUseCase>()),
);

final priceUpdatesNotifierProvider =
    StateNotifierProvider<PriceUpdatesNotifier, PriceUpdatesState>(
  (ref) => PriceUpdatesNotifier(
    getIt<ConnectToRealTimeServerUseCase>(),
    getIt<SubscribeSymbolUseCase>(),
    getIt<GetPriceUpdatesStreamUseCase>(),
  ),
);
