import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stocks_app/trades/domain/entities/trade_symbol.dart';

part 'search_symbols_state.freezed.dart';

@freezed
class SearchSymbolsState with _$SearchSymbolsState {
  /// Empty constructor
  const SearchSymbolsState._();

  /// Initial state
  const factory SearchSymbolsState.initial() = _Initial;

  /// Loading: state of symbols while waiting for information
  const factory SearchSymbolsState.loading() = _Loading;

  /// Loading: state of symbols when have information
  const factory SearchSymbolsState.data({
    required List<TradeSymbol> symbols,
  }) = _Data;

  /// Error: state when error occurs
  const factory SearchSymbolsState.error() = _Error;
}
