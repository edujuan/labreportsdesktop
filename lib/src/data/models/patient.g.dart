// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Patient _$PatientFromJson(Map<String, dynamic> json) => Patient(
      gender: json['gender'] as String,
      name: json['name'] as String,
      birthDate: DateTime.parse(json['birthDate'] as String),
      id: json['id'] as String,
      phoneNumber: json['phoneNumber'] as String,
      history: json['history'] == null
          ? null
          : PatientHistory.fromJson(json['history'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PatientToJson(Patient instance) => <String, dynamic>{
      'name': instance.name,
      'history': instance.history,
      'birthDate': instance.birthDate.toIso8601String(),
      'id': instance.id,
      'gender': instance.gender,
      'phoneNumber': instance.phoneNumber,
    };
