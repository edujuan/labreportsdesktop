import 'package:json_annotation/json_annotation.dart';

import 'biomarker.dart';

part 'report.g.dart';

@JsonSerializable()
class Report {
  final String id;
  final String name;
  final DateTime reportDate;
  final Map<String, Biomarker> biomarkerValues;
  final String patientId;
  final String summary;
  final List<String> recommendations;
  final String doctorName;
  final bool displayed;

  const Report({
    required this.id,
    required this.name,
    required this.reportDate,
    required this.biomarkerValues,
    required this.patientId,
    required this.summary,
    required this.recommendations,
    required this.doctorName,
    required this.displayed,
  });

  factory Report.fromJson(Map<String, dynamic> json) => _$ReportFromJson(json);

  Map<String, dynamic> toJson() => _$ReportToJson(this);

  @override
  String toString() => '$name $reportDate';
}
