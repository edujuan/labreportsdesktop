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
    final info =
        'Name: ${patient.name}\nBirth Date: ${patient.birthDate.day}/${patient.birthDate.month}/${patient.birthDate.year}\nPhone Number: ${patient.phoneNumber}\nWeight: ${patient.history?.weight ?? 'Unknown'}kg\nHeight: ${patient.history?.height ?? 'Unknown'}cm';

    return Column(
      children: [
        _buildPatientProfileRow(
          'Information',
          info,
        ),
        const SizedBox(height: 16),
        _buildPatientProfileRow(
          'Anamnesis',
          patient.history?.text ?? 'No history available',
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
