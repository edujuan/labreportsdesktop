import 'package:json_annotation/json_annotation.dart';

part 'biomarker_data_point.g.dart';

@JsonSerializable()
class BiomarkerDataPoint {
  final String name;
  final double value;
  final String date;

  BiomarkerDataPoint(
      {required this.name, required this.value, required this.date});

  factory BiomarkerDataPoint.fromJson(Map<String, dynamic> json) =>
      _$BiomarkerDataPointFromJson(json);

  Map<String, dynamic> toJson() => _$BiomarkerDataPointToJson(this);
}
