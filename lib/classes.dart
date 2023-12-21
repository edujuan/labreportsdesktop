import 'package:uuid/uuid.dart';

import 'biomarker.dart';


class LabReportAndPatient {
  final LabReportDto labReport;
  final Patient patient;

  LabReportAndPatient({required this.labReport, required this.patient});
}

class Patient {
  final String name;
  final PatientHistory? history;
  final DateTime birthDate;
  final String id;

  Patient({
    required this.name,
    this.history,
    required this.birthDate,
    String? id,
  }) : id = id ?? Uuid().v4();
}


class PatientHistory {
  final String text;
  final int weight;
  final int height;

  PatientHistory({required this.text, required this.weight, required this.height});
}

class LabReportDto {
  final String executiveSummary;
  final String recommendations;
  final Map<String, Biomarker> biomarkerValues;
  final String patientId;
  final String doctorName;
  final DateTime reportDate;
  final String name;
  final String id;

  LabReportDto({
    required this.executiveSummary,
    required this.recommendations,
    required this.biomarkerValues,
    required this.patientId,
    required this.doctorName,
    required this.reportDate,
    required this.name,
    String? id,
  }) : id = id ?? Uuid().v4();
}
