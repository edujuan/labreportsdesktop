import 'package:json_annotation/json_annotation.dart';

import 'patient.dart';
import 'report.dart';

part 'lab_report_and_patient.g.dart';

@JsonSerializable()
class LabReportAndPatient {
  final Report labReport;
  final Patient patient;

  LabReportAndPatient({required this.labReport, required this.patient});

  factory LabReportAndPatient.fromJson(Map<String, dynamic> json) =>
      _$LabReportAndPatientFromJson(json);
  Map<String, dynamic> toJson() => _$LabReportAndPatientToJson(this);
}
