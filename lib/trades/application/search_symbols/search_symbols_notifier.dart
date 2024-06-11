import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stocks_app/trades/application/search_symbols/search_symbols_state.dart';
import 'package:stocks_app/trades/domain/usecases/search_symbols_use_case.dart';

class SearchSymbolsNotifier extends StateNotifier<SearchSymbolsState> {
  SearchSymbolsNotifier(
    this._searchSymbolsUseCase,
  ) : super(const SearchSymbolsState.initial());

  final SearchSymbolsUseCase _searchSymbolsUseCase;

  String? lastQuery;

  Future searchSymbols(String query) async {
    state = const SearchSymbolsState.loading();

    final result = await _searchSymbolsUseCase.execute(query);

    state = result.fold(
      (l) => const SearchSymbolsState.error(),
      (r) {
        lastQuery = query;
        return SearchSymbolsState.data(symbols: r);
      },
    );
  }
}
