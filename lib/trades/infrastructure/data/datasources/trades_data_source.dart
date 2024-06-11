import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stocks_app/core/domain/entities/app_config.dart';
import 'package:stocks_app/trades/infrastructure/data/datasources/trades_data_const.dart';
import 'package:stocks_app/trades/infrastructure/data/dtos/price_update_dto.dart';
import 'package:stocks_app/trades/infrastructure/data/dtos/stock_quote_dto.dart';
import 'package:stocks_app/trades/infrastructure/data/dtos/trade_symbol_dto.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

abstract class TradesDataSource {
  Future<List<TradeSymbolDTO>> searchSymbols(String name);
  Future<bool> isConnectedToPriceUpdates();
  Future<Stream<PriceUpdateDTO>> getPriceUpdatesStream();
  Future<void> subscribeToSymbol(String symbol);
  Future<void> unsubscribeToSymbol(String symbol);
  Future<bool> connectToRealTimeServer();
  Future<StockQuoteDTO> getStockQuote(String symbol);
}

@Singleton(as: TradesDataSource)
class TradesDataSourceImpl implements TradesDataSource {
  final AppConfig _appConfig;
  final Dio _dio;

  WebSocketChannel? channel;
  StreamSubscription? streamSubscription;

  final BehaviorSubject<bool> _isConnectedStream =
      BehaviorSubject.seeded(false);

  final BehaviorSubject<PriceUpdateDTO> _priceUpdateSubject = BehaviorSubject();

  TradesDataSourceImpl(this._appConfig, this._dio);

  Future listenSocket() async {
    if (channel != null) {
      streamSubscription = channel!.stream.listen(
        (event) {
          final data = jsonDecode(event);

          if (data['type'] == 'trade') {
            for (var element in (data['data'] as List)) {
              _priceUpdateSubject.value = PriceUpdateDTO.fromJson(element);
            }
          }
        },
      );
    }
  }

  Future<bool> connectSocket() async {
    /// Early return true if already connected
    if (_isConnectedStream.value) {
      return true;
    }

    try {
      channel = WebSocketChannel.connect(
        Uri.parse('wss://ws.finnhub.io?token=${_appConfig.apiKey}'),
      );
      await channel!.ready;
      listenSocket();
      _isConnectedStream.value = true;
      return true;
    } catch (_) {
      await disconnectSocket();
      return false;
    }
  }

  Future disconnectSocket() async {
    await channel?.sink.close();
    streamSubscription?.cancel();
    channel = null;
    _isConnectedStream.value = false;
  }

  @override
  Future<List<TradeSymbolDTO>> searchSymbols(String name) async {
    final requestUri = Uri.https(
      _appConfig.apiHost,
      TradesDataConst.searchSymbolsEndpoint.value,
      {
        'token': _appConfig.apiKey,
        'q': name,
      },
    );

    final response = await _dio.getUri(requestUri);

    if (response.statusCode == 200 &&
        response.data['result'] != null &&
        response.data['result'] is List) {
      return (response.data['result'] as List)
          .map<TradeSymbolDTO>((e) => TradeSymbolDTO.fromJson(e))
          .toList();
    }

    throw Exception('Data exception');
  }

  @override
  Future<bool> isConnectedToPriceUpdates() {
    return Future.value(_isConnectedStream.value);
  }

  @override
  Future<Stream<PriceUpdateDTO>> getPriceUpdatesStream() {
    return Future.value(_priceUpdateSubject.stream);
  }

  @override
  Future<void> subscribeToSymbol(String symbol) async {
    channel?.sink.add(jsonEncode({
      'type': 'subscribe',
      'symbol': symbol,
    }));
  }

  @override
  Future<void> unsubscribeToSymbol(String symbol) {
    // TODO: implement unsubscribeToSymbol
    throw UnimplementedError();
  }

  @override
  Future<bool> connectToRealTimeServer() {
    return connectSocket();
  }

  @override
  Future<StockQuoteDTO> getStockQuote(String symbol) async {
    final requestUri = Uri.https(
      _appConfig.apiHost,
      TradesDataConst.getStockQuoteEndpoint.value,
      {
        'token': _appConfig.apiKey,
        'symbol': symbol,
      },
    );

    final response = await _dio.getUri(requestUri);

    if (response.statusCode == 200) {
      return StockQuoteDTO.fromJson(response.data);
    }
    throw Exception('Data exception');
  }
}
