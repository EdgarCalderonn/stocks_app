import 'package:freezed_annotation/freezed_annotation.dart';

part 'trade_symbol_dto.g.dart';

@JsonSerializable()
class TradeSymbolDTO {
  final String description;
  final String displaySymbol;
  final String symbol;
  final String type;

  TradeSymbolDTO({
    required this.description,
    required this.displaySymbol,
    required this.symbol,
    required this.type,
  });

  factory TradeSymbolDTO.fromJson(Map<String, dynamic> json) =>
      _$TradeSymbolDTOFromJson(json);

  Map<String, dynamic> toJson() => _$TradeSymbolDTOToJson(this);
}
