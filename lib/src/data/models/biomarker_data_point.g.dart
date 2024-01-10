// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'biomarker_data_point.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BiomarkerDataPoint _$BiomarkerDataPointFromJson(Map<String, dynamic> json) =>
    BiomarkerDataPoint(
      name: json['name'] as String,
      value: (json['value'] as num).toDouble(),
      date: json['date'] as String,
    );

Map<String, dynamic> _$BiomarkerDataPointToJson(BiomarkerDataPoint instance) =>
    <String, dynamic>{
      'name': instance.name,
      'value': instance.value,
      'date': instance.date,
    };
