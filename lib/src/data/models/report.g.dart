// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Report _$ReportFromJson(Map<String, dynamic> json) => Report(
      id: json['id'] as String,
      name: json['name'] as String,
      reportDate: DateTime.parse(json['reportDate'] as String),
      biomarkerValues: (json['biomarkerValues'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, Biomarker.fromJson(e as Map<String, dynamic>)),
      ),
      patientId: json['patientId'] as String,
      summary: json['summary'] as String,
      recommendations: (json['recommendations'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      doctorName: json['doctorName'] as String,
      displayed: json['displayed'] as bool,
    );

Map<String, dynamic> _$ReportToJson(Report instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'reportDate': instance.reportDate.toIso8601String(),
      'biomarkerValues': instance.biomarkerValues,
      'patientId': instance.patientId,
      'summary': instance.summary,
      'recommendations': instance.recommendations,
      'doctorName': instance.doctorName,
      'displayed': instance.displayed,
    };
