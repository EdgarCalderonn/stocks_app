import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stocks_app/trades/application/providers.dart';

class TradeDetailPage extends ConsumerStatefulWidget {
  const TradeDetailPage({
    super.key,
    required this.symbolId,
    required this.openPriceOfTheDay,
  });

  final String symbolId;
  final double openPriceOfTheDay;

  @override
  ConsumerState<TradeDetailPage> createState() => _TradeDetailPageState();
}

class _TradeDetailPageState extends ConsumerState<TradeDetailPage> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(priceUpdatesNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.symbolId),
        actions: state.maybeWhen(
            connected: (updates, updatesHistory, lastUpdates) {
              final priceNotifier =
                  ref.read(priceUpdatesNotifierProvider.notifier);
              final lastUpdate = priceNotifier.getLastUpdate(widget.symbolId);
              final double percentage = priceNotifier.getPercentage(
                widget.openPriceOfTheDay,
                lastUpdate!.lastPrice,
              );
              final color = percentage > 0 ? Colors.green : Colors.red;
              return [
                Icon(
                  percentage > 0
                      ? Icons.arrow_upward_rounded
                      : Icons.arrow_downward_rounded,
                  color: color,
                ),
                const SizedBox(width: 20),
                Text(
                  lastUpdate.lastPrice.toString(),
                  style: TextStyle(color: color),
                ),
                const SizedBox(width: 20),
              ];
            },
            orElse: () => []),
      ),
      body: state.maybeWhen(
          connected: (updates, updatesHistory, lastUpdates) {
            final updates = ref
                .read(priceUpdatesNotifierProvider.notifier)
                .getUpdatesOfSymbol(widget.symbolId);

            return LineChart(LineChartData(
                minX: (updates.length.toDouble() - 10) > 0
                    ? (updates.length.toDouble() - 10)
                    : 0,
                maxX: updates.length.toDouble() - 1,
                minY: updates
                        .map((spot) => spot.lastPrice)
                        .reduce((a, b) => a < b ? a : b) -
                    .5,
                maxY: updates
                        .map((spot) => spot.lastPrice)
                        .reduce((a, b) => a > b ? a : b) +
                    .5,
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: const Color(0xff37434d), width: 1),
                ),
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      ...updates
                          .map<FlSpot>(
                            (e) => FlSpot(
                              updates.indexOf(e) + 1,
                              e.lastPrice,
                            ),
                          )
                          .toList(),
                    ],
                  )
                ]));
          },
          orElse: () => const Center(
                child: Text('No data'),
              )),
    );
  }
}
