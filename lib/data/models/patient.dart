import 'package:json_annotation/json_annotation.dart';
import 'package:lab4_doctors/data/models/patientHistory.dart';

part 'patient.g.dart';

@JsonSerializable()
class Patient {
  final String name;
  final PatientHistory? history;
  final DateTime birthDate;
  final String id;

  Patient({
    required this.name,
    this.history,
    required this.birthDate,
    required this.id,
  });

  factory Patient.fromJson(Map<String, dynamic> json) => _$PatientFromJson(json);
  Map<String, dynamic> toJson() => _$PatientToJson(this);
}