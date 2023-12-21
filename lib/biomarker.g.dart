// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'biomarker.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Biomarker _$BiomarkerFromJson(Map<String, dynamic> json) => Biomarker(
      id: json['id'] as String,
      name: json['name'] as String,
      bucket: json['bucket'] as String,
      value: (json['value'] as num).toDouble(),
      minValue: (json['minValue'] as num?)?.toDouble(),
      maxValue: (json['maxValue'] as num?)?.toDouble(),
      unit: json['unit'] as String,
      biomarkerDescription: json['biomarkerDescription'] as String,
      rangeDescription: json['rangeDescription'] as String,
    );

Map<String, dynamic> _$BiomarkerToJson(Biomarker instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'bucket': instance.bucket,
      'value': instance.value,
      'minValue': instance.minValue,
      'maxValue': instance.maxValue,
      'unit': instance.unit,
      'biomarkerDescription': instance.biomarkerDescription,
      'rangeDescription': instance.rangeDescription,
    };
