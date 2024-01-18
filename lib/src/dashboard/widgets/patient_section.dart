import 'dart:math';

import 'package:flutter/material.dart';

import '../../data/data.dart';

class PatientSection extends StatelessWidget {
  final Patient patient;

  const PatientSection({
    super.key,
    required this.patient,
  });

  @override
  Widget build(BuildContext context) {
    final bmi =
        (patient.history!.weight / (pow((patient.history!.height / 100), 2)))
            .toStringAsFixed(2);
    final info =
        'Name: ${patient.name}\nBirth Date: ${patient.birthDate.day}/${patient.birthDate.month}/${patient.birthDate.year}\nGender: ${patient.gender}\nWeight: ${patient.history?.weight ?? 'Unknown'}kg\nHeight: ${patient.history?.height ?? 'Unknown'}cm\nBMI: $bmi';

    return Column(
      children: [
        _buildPatientProfileRow(
          'Information',
          info,
        ),
        const SizedBox(height: 16),
        _buildPatientProfileRow(
          'Anamnesis',
          patient.history?.anamnesis ?? 'No history available',
        ),
      ],
    );
  }

  Widget _buildPatientProfileRow(String title, String content) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(content),
        ],
      ),
    );
  }
}
