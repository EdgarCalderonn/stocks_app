import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stocks_app/trades/application/providers.dart';
import 'package:stocks_app/trades/presentation/pages/add_symbol_page.dart';
import 'package:stocks_app/trades/presentation/pages/trade_detail_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    connectToPriceUpdates();
  }

  Future connectToPriceUpdates() async {
    ref.read(priceUpdatesNotifierProvider.notifier).connect();
  }

  final BehaviorSubject<int> mySubject = BehaviorSubject<int>();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(tradeAlertsNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trades'),
      ),
      body: state.maybeWhen(
        empty: () => GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddSymbolPage(),
              ),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/add.png',
                  color: Colors.white,
                  height: 50,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Add new symbol',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),
        data: (alerts) {
          if (alerts.isEmpty) {
            return GestureDetector(
              onTap: () {
                print('add');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddSymbolPage(),
                  ),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/add.png',
                      color: Colors.white,
                      height: 50,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Add new symbol',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: alerts.length,
            itemBuilder: (context, index) {
              final alert = alerts[index];
              final symbol = alert.tradeSymbol;
              final initialQuote = alert.initialStockQuote;

              final priceUpdateState = ref.watch(priceUpdatesNotifierProvider);
              final priceNotifier =
                  ref.read(priceUpdatesNotifierProvider.notifier);

              final bool isUpdated =
                  priceNotifier.isUpdatedSymbol(symbol.symbol);

              if (isUpdated) {
                final update = priceNotifier.getLastUpdate(symbol.symbol)!;
                final double percentage = priceNotifier.getPercentage(
                  initialQuote.openPriceOfTheDay,
                  update.lastPrice,
                );
                final color = percentage > 0 ? Colors.green : Colors.red;
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TradeDetailPage(
                          symbolId: symbol.symbol,
                          openPriceOfTheDay: initialQuote.openPriceOfTheDay,
                        ),
                      ),
                    );
                  },
                  leading: percentage > 0
                      ? Icon(Icons.arrow_upward, color: color)
                      : Icon(Icons.arrow_downward, color: color),
                  title:
                      Text('${symbol.displaySymbol} - ${symbol.description}'),
                  subtitle: Text(
                    '${percentage.toStringAsFixed(3)}%',
                    style: TextStyle(
                      color: color,
                    ),
                  ),
                  trailing: Text(
                    update.lastPrice.toString(),
                    style: TextStyle(
                      color: color,
                      fontSize: 20,
                    ),
                  ),
                );
              } else {}

              return ListTile(
                onTap: () {
                  ref
                      .read(priceUpdatesNotifierProvider.notifier)
                      .subscribeSymbol(symbol.symbol);
                },
                leading: const Icon(Icons.account_balance_rounded),
                title: Text('${symbol.displaySymbol} - ${symbol.description}'),
                subtitle: Text(initialQuote.currentPrice.toString()),
                trailing: Text(
                  initialQuote.currentPrice.toString(),
                ),
              );
            },
          );
        },
        orElse: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddSymbolPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
