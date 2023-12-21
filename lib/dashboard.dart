import 'package:flutter/material.dart';
import 'classes.dart';


class Dashboard5Widget extends StatefulWidget {
  final Function setSelectedLabReportAndPatient;
  final LabReportAndPatient? selectedPatient;

  const Dashboard5Widget({required this.setSelectedLabReportAndPatient, this.selectedPatient, Key? key}) : super(key: key);

  @override
  _Dashboard5WidgetState createState() => _Dashboard5WidgetState();
}

class _Dashboard5WidgetState extends State<Dashboard5Widget> with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color(0xFFF1F4F8),
        body: SafeArea(
          child: Row(
            children: [Expanded(child: _buildDashboardContent())],
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeader(),
          _buildPatientProfileSection(),
          _buildBiomarkersSection(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      height: 140,
      constraints: const BoxConstraints(
        maxHeight: 140,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            color: Color(0x33000000),
            offset: Offset(0, 1),
          )
        ],
      ),
      child: Row(
        children: [
          const Expanded(
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 4),
              child: Text('Ja'),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 55,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: 3,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return _buildProfileCard(index);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard(int index) {
    IconData iconData;
    switch (index) {
      case 0:
        iconData = Icons.edit; // Pencil icon
        break;
      case 1:
        iconData = Icons.close; // X icon
        break;
      case 2:
        iconData = Icons.check; // Checkmark icon
        break;
      default:
        iconData = Icons.help; // Default icon
    }

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 8, 8),
      child: Container(
        width: 95,
        height: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFD9D9D9),
          borderRadius: BorderRadius.circular(50),
          shape: BoxShape.rectangle,
          border: Border.all(
            color: const Color(0xFFE0E3E7),
            width: 2,
          ),
        ),
        child: Center(
          child: Icon(iconData, color: Colors.black), // Display the icon
        ),
      ),
    );
  }

  Widget _buildPatientProfileSection() {
  if (widget.selectedPatient == null) {
    return _buildSectionContainer(
      children: [Text('No patient selected')],
    );
  }

  LabReportAndPatient patient = widget.selectedPatient!;
  String patientInfo = 'Name: ${patient.patient.name}\n'
                       'Birth Date: ${patient.patient.birthDate}\n'
                       'Weight: ${patient.patient.history?.weight ?? 'Unknown'}kg\n'
                       'Height: ${patient.patient.history?.height ?? 'Unknown'}cm';

  String patientHistory = patient.patient.history?.text ?? 'No history available';

  return _buildSectionContainer(
    children: [
      Row(
        children: [
          Expanded(
            child: _buildPatientProfileRow(
              'Patient Profile',
              patientInfo,
              '',  // Other details can be added as needed
              '',
              '',
            ),
          ),
          Expanded(
            child: _buildPatientProfileRow(
              'Anamnesis',
              patientHistory,
              '',  // Other details can be added as needed
              '',
              '',
            ),
          ),
        ],
      ),
    ],
  );
}



  Widget _buildPatientProfileRow(String title, String line1, String line2, String line3, String line4) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
      child: Container(
        width: double.infinity,
        decoration: _sectionDecoration(),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,  // Align text to the left
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(line1),
              if (line2.isNotEmpty) Text(line2),
              if (line3.isNotEmpty) Text(line3),
              if (line4.isNotEmpty) Text(line4),
            ],
          ),
        ),
      ),
    );
  }


Widget _buildBiomarkersSection() {
  // Check if a biomarker is selected
  if (widget.selectedPatient == null) {
    return _buildSectionContainer(
      children: [Text('No biomarker selected')],
    );
  }

  LabReportAndPatient patient = widget.selectedPatient!;

  return _buildSectionContainer(
    children: [
      _buildBiomarkerRow(patient.patient.name,'${patient.labReport.biomarkerValues.toString()} '),
      // You can add more rows if needed
    ],
  );
}

  Widget _buildBiomarkerRow(String title, String value) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
      child: Container(
        width: double.infinity,
        decoration: _sectionDecoration(),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 2, 0, 2),
          child: Row(
            children: [
              const SizedBox(
                height: 100,
                child: VerticalDivider(
                  width: 24,
                  thickness: 4,
                  indent: 12,
                  endIndent: 12,
                  color: Colors.black,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(8, 12, 16, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(title)],
                  ),
                ),
              ),
              Expanded(
                child: Text(value),
              ),
              Expanded(
                child: Container(
                  width: 300,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }




  Widget _buildSectionContainer({required List<Widget> children}) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
      child: Container(
        decoration: _sectionDecoration(),
        child: Column(children: children),
      ),
    );
  }

  BoxDecoration _sectionDecoration() {
    return BoxDecoration(
      color: Colors.white,
      // boxShadow: [BoxShadow(blurRadius: 3, color: const Color(0x33000000), offset: const Offset(0, 1))],
      borderRadius: BorderRadius.circular(24),
    );
  }
}
