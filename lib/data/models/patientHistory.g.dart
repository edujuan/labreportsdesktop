// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patientHistory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientHistory _$PatientHistoryFromJson(Map<String, dynamic> json) =>
    PatientHistory(
      text: json['text'] as String,
      weight: json['weight'] as int,
      height: json['height'] as int,
    );

Map<String, dynamic> _$PatientHistoryToJson(PatientHistory instance) =>
    <String, dynamic>{
      'text': instance.text,
      'weight': instance.weight,
      'height': instance.height,
    };
