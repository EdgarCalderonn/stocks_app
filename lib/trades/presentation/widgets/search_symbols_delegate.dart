import 'package:flutter/material.dart';
import 'package:stocks_app/trades/presentation/widgets/search_symbols_results.dart';

class SearchSymbolsDelegate<TradeSymbol> extends SearchDelegate {
  @override
  String? get searchFieldLabel => 'Search symbols';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.pop(context),
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SearchSymbolsResults(query: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const SizedBox.shrink();
  }
}
