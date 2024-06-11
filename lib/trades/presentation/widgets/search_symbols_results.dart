import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stocks_app/core/presentation/widgets/retry_widget.dart';
import 'package:stocks_app/trades/application/providers.dart';

class SearchSymbolsResults extends ConsumerStatefulWidget {
  const SearchSymbolsResults({
    super.key,
    required this.query,
  });

  final String query;

  @override
  ConsumerState<SearchSymbolsResults> createState() =>
      _SearchSymbolsResultsState();
}

class _SearchSymbolsResultsState extends ConsumerState<SearchSymbolsResults> {
  @override
  void initState() {
    super.initState();
    Future.microtask(getData);
  }

  void getData() {
    ref
        .read(searchSymbolsNotifierProvider.notifier)
        .searchSymbols(widget.query);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(searchSymbolsNotifierProvider);

    return state.maybeWhen(
      data: (symbols) {
        if (symbols.isEmpty) {
          return const Center(
            child: Text('No results'),
          );
        }

        return ListView.builder(
          itemCount: symbols.length,
          itemBuilder: (context, index) {
            final symbol = symbols[index];

            return ListTile(
              leading: const Icon(Icons.account_balance_rounded),
              title: Text(symbol.displaySymbol),
              subtitle: Text(symbol.description),
              onTap: () {
                Navigator.pop(context, symbol);
              },
            );
          },
        );
      },
      error: () => RetryWidget(retryFunction: getData),
      orElse: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
