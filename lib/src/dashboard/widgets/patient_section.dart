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
              Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(content),
            ],
          ),
        ),
      ),
    );
  }
}
