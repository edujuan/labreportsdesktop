// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientHistory _$PatientHistoryFromJson(Map<String, dynamic> json) =>
    PatientHistory(
      previousIllnessesAndDiagnoses:
          json['previousIllnessesAndDiagnoses'] as String,
      currentHealthStatus: json['currentHealthStatus'] as String,
      anamnesis: json['anamnesis'] as String,
      medicationsAndTreatments: json['medicationsAndTreatments'] as String,
      weight: json['weight'] as int,
      height: json['height'] as int,
    );

Map<String, dynamic> _$PatientHistoryToJson(PatientHistory instance) =>
    <String, dynamic>{
      'previousIllnessesAndDiagnoses': instance.previousIllnessesAndDiagnoses,
      'currentHealthStatus': instance.currentHealthStatus,
      'anamnesis': instance.anamnesis,
      'medicationsAndTreatments': instance.medicationsAndTreatments,
      'weight': instance.weight,
      'height': instance.height,
    };
