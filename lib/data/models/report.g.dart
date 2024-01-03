// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Report _$ReportFromJson(Map<String, dynamic> json) => Report(
      id: json['id'] as String,
      name: json['name'] as String,
      reportDate: json['reportDate'] as String,
      biomarkerValues: (json['biomarkerValues'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, Biomarker.fromJson(e as Map<String, dynamic>)),
      ),
      patientId: json['patientId'] as String,
      executiveSummary: json['executiveSummary'] as String,
      recommendations: json['recommendations'] as String,
      doctorName: json['doctorName'] as String,
      displayed: json['displayed'] as bool,
    );

Map<String, dynamic> _$ReportToJson(Report instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'reportDate': instance.reportDate,
      'biomarkerValues': instance.biomarkerValues,
      'patientId': instance.patientId,
      'executiveSummary': instance.executiveSummary,
      'recommendations': instance.recommendations,
      'doctorName': instance.doctorName,
      'displayed': instance.displayed,
    };
