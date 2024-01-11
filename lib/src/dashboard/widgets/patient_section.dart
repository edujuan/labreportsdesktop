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
    return _buildPatientProfileRow(
      'Anamnesis',
      patient.history?.text ?? 'No history available',
    );

    //  Expanded(
    //       child: _buildPatientProfileRow(
    //         'Patient Profile',
    //         _formatPatientInfo(patient),
    //       ),
    //     ),
  }

  String _formatPatientInfo(Patient patient) {
    return 'Name: ${patient.name}\nBirth Date: ${patient.birthDate.day}/${patient.birthDate.month}/${patient.birthDate.year}\nWeight: ${patient.history?.weight ?? 'Unknown'}kg\nHeight: ${patient.history?.height ?? 'Unknown'}cm';
  }

  Widget _buildPatientProfileRow(String title, String content) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
              Text(content),
            ],
          ),
        ),
      ),
    );
  }
}
