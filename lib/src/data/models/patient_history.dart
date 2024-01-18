import 'package:json_annotation/json_annotation.dart';

part 'patient_history.g.dart';

@JsonSerializable()
class PatientHistory {
  final String anamnesis;
  final String previousIllnessesAndDiagnoses;
  final String currentHealthStatus;
  final String medicationsAndTreatments;
  final int weight;
  final int height;

  PatientHistory({
    required this.anamnesis,
    required this.previousIllnessesAndDiagnoses,
    required this.currentHealthStatus,
    required this.medicationsAndTreatments,
    required this.weight,
    required this.height,
  });

  factory PatientHistory.fromJson(Map<String, dynamic> json) =>
      _$PatientHistoryFromJson(json);
  Map<String, dynamic> toJson() => _$PatientHistoryToJson(this);
}
