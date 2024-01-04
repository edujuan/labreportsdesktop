// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lab_report_and_patient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LabReportAndPatient _$LabReportAndPatientFromJson(Map<String, dynamic> json) =>
    LabReportAndPatient(
      labReport: Report.fromJson(json['labReport'] as Map<String, dynamic>),
      patient: Patient.fromJson(json['patient'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LabReportAndPatientToJson(
        LabReportAndPatient instance) =>
    <String, dynamic>{
      'labReport': instance.labReport,
      'patient': instance.patient,
    };
