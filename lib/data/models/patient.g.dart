// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Patient _$PatientFromJson(Map<String, dynamic> json) => Patient(
      name: json['name'] as String,
      history: json['history'] == null
          ? null
          : PatientHistory.fromJson(json['history'] as Map<String, dynamic>),
      birthDate: DateTime.parse(json['birthDate'] as String),
      id: json['id'] as String,
    );

Map<String, dynamic> _$PatientToJson(Patient instance) => <String, dynamic>{
      'name': instance.name,
      'history': instance.history,
      'birthDate': instance.birthDate.toIso8601String(),
      'id': instance.id,
    };
