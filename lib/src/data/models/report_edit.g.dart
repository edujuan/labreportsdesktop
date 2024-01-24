// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_edit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportEdit _$ReportEditFromJson(Map<String, dynamic> json) => ReportEdit(
      summary: json['summary'] as String?,
      recommendations: (json['recommendations'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ReportEditToJson(ReportEdit instance) =>
    <String, dynamic>{
      'summary': instance.summary,
      'recommendations': instance.recommendations,
    };
