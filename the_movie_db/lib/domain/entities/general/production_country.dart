import 'package:json_annotation/json_annotation.dart';

part 'production_country.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ProductionCountry {
  ProductionCountry({
    required this.iso,
    required this.name,
  });

  factory ProductionCountry.fromJson(Map<String, dynamic> json) =>
      _$ProductionCountryFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCountryToJson(this);

  @JsonKey(name: 'iso_3166_1')
  final String iso;
  final String name;

  @override
  String toString() {
    return iso;
  }
}
