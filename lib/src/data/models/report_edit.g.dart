// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_edit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportEdit _$ReportEditFromJson(Map<String, dynamic> json) => ReportEdit(
      executiveSummary: json['executiveSummary'] as String?,
      recommendations: (json['recommendations'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ReportEditToJson(ReportEdit instance) =>
    <String, dynamic>{
      'executiveSummary': instance.executiveSummary,
      'recommendations': instance.recommendations,
    };
