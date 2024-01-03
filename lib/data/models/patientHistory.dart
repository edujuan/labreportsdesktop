import 'package:json_annotation/json_annotation.dart';

part 'patientHistory.g.dart';

@JsonSerializable()
class PatientHistory {
  final String text;
  final int weight;
  final int height;

  PatientHistory({required this.text, required this.weight, required this.height});


  factory PatientHistory.fromJson(Map<String, dynamic> json) => _$PatientHistoryFromJson(json);
  Map<String, dynamic> toJson() => _$PatientHistoryToJson(this);
}
