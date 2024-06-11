import 'package:freezed_annotation/freezed_annotation.dart';

part 'stock_quote_dto.g.dart';

@JsonSerializable()
class StockQuoteDTO {
  @JsonKey(name: 'c')
  final double currentPrice;
  @JsonKey(name: 'd')
  final double change;
  @JsonKey(name: 'dp')
  final double percentChange;
  @JsonKey(name: 'h')
  final double highPriceOfTheDay;
  @JsonKey(name: 'l')
  final double lowPriceOfTheDay;
  @JsonKey(name: 'o')
  final double openPriceOfTheDay;
  @JsonKey(name: 'pc')
  final double previousClosePrice;

  StockQuoteDTO({
    required this.currentPrice,
    required this.change,
    required this.percentChange,
    required this.highPriceOfTheDay,
    required this.lowPriceOfTheDay,
    required this.openPriceOfTheDay,
    required this.previousClosePrice,
  });

  factory StockQuoteDTO.fromJson(Map<String, dynamic> json) =>
      _$StockQuoteDTOFromJson(json);

  Map<String, dynamic> toJson() => _$StockQuoteDTOToJson(this);
}
