// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientHistory _$PatientHistoryFromJson(Map<String, dynamic> json) =>
    PatientHistory(
      anamnesis: json['anamnesis'] as String,
      previousIllnessesAndDiagnoses:
          json['previousIllnessesAndDiagnoses'] as String,
      currentHealthStatus: json['currentHealthStatus'] as String,
      medicationsAndTreatments: json['medicationsAndTreatments'] as String,
      weight: json['weight'] as int,
      height: json['height'] as int,
    );

Map<String, dynamic> _$PatientHistoryToJson(PatientHistory instance) =>
    <String, dynamic>{
      'anamnesis': instance.anamnesis,
      'previousIllnessesAndDiagnoses': instance.previousIllnessesAndDiagnoses,
      'currentHealthStatus': instance.currentHealthStatus,
      'medicationsAndTreatments': instance.medicationsAndTreatments,
      'weight': instance.weight,
      'height': instance.height,
    };
