import 'package:json_annotation/json_annotation.dart';

import 'patient_history.dart';

part 'patient.g.dart';

@JsonSerializable()
class Patient {
  final String name;
  final PatientHistory? history;
  final DateTime birthDate;
  final String id;
  final String phoneNumber;

  Patient({
    required this.name,
    this.history,
    required this.birthDate,
    required this.id,
    required this.phoneNumber,
  });

  factory Patient.fromJson(Map<String, dynamic> json) =>
      _$PatientFromJson(json);
  Map<String, dynamic> toJson() => _$PatientToJson(this);
}
