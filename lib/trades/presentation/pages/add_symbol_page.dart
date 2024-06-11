import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stocks_app/trades/application/providers.dart';
import 'package:stocks_app/trades/domain/entities/trade_symbol.dart';
import 'package:stocks_app/trades/presentation/widgets/search_symbols_delegate.dart';

class AddSymbolPage extends ConsumerStatefulWidget {
  const AddSymbolPage({super.key});

  @override
  ConsumerState<AddSymbolPage> createState() => _AddSymbolPageState();
}

class _AddSymbolPageState extends ConsumerState<AddSymbolPage> {
  @override
  void initState() {
    super.initState();
  }

  void subscribeToAlerts() {
    ref.listen(
      tradeAlertsNotifierProvider,
      (previous, next) {
        next.maybeWhen(
          data: (alerts) {
            ref
                .read(priceUpdatesNotifierProvider.notifier)
                .subscribeSymbol(tradeSymbol!.symbol);
            Navigator.pop(context);
          },
          error: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Error'),
                content: const Text('An error ocurred'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Ok'))
                ],
              ),
            );
          },
          orElse: () {},
        );
      },
    );
  }

  TradeSymbol? tradeSymbol;
  double? priceAlertValue;

  @override
  Widget build(BuildContext context) {
    subscribeToAlerts();

    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add symbol'),
        ),
        body: Container(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Column(
            children: [
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () async {
                  final result = await showSearch(
                    context: context,
                    delegate: SearchSymbolsDelegate(),
                  );

                  if (result != null) {
                    setState(() {
                      tradeSymbol = result;
                    });
                  }
                },
                child: TextField(
                  ignorePointers: true,
                  controller:
                      TextEditingController(text: tradeSymbol?.displaySymbol),
                  decoration: const InputDecoration(
                    label: Text('Name of symbol'),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                onChanged: (value) {
                  try {
                    priceAlertValue = double.parse(value);
                    setState(() {});
                  } catch (_) {
                    setState(() {
                      priceAlertValue = null;
                    });
                  }
                },
                decoration: const InputDecoration(
                  label: Text('Price alert value'),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: (tradeSymbol != null && priceAlertValue != null)
                    ? () {
                        ref
                            .read(tradeAlertsNotifierProvider.notifier)
                            .addTradeAlert(tradeSymbol!, priceAlertValue!);
                        // Navigator.pop(context);
                      }
                    : null,
                child: const Text('Create'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
