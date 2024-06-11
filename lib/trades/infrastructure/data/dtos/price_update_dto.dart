import 'package:freezed_annotation/freezed_annotation.dart';

part 'price_update_dto.g.dart';

@JsonSerializable()
class PriceUpdateDTO {
  @JsonKey(name: 's')
  final String symbol;
  @JsonKey(name: 'p')
  final double lastPrice;
  @JsonKey(name: 't')
  final int timeStamp;
  @JsonKey(name: 'v')
  final double volume;

  PriceUpdateDTO({
    required this.symbol,
    required this.lastPrice,
    required this.timeStamp,
    required this.volume,
  });

  factory PriceUpdateDTO.fromJson(Map<String, dynamic> json) =>
      _$PriceUpdateDTOFromJson(json);

  Map<String, dynamic> toJson() => _$PriceUpdateDTOToJson(this);
}
