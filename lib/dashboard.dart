// import 'dart:ffi';

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
  final TextEditingController _paragraphController = TextEditingController();
  final FocusNode _paragraphFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _updateParagraphText();
  }

  @override
  void didUpdateWidget(Dashboard5Widget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedPatient != oldWidget.selectedPatient) {
      _updateParagraphText();
    }
  }

  void _updateParagraphText() {
    if (widget.selectedPatient != null) {
      _paragraphController.text = widget.selectedPatient!.labReport.executiveSummary;
    }
  }

  @override
  void dispose() {
    _paragraphController.dispose();
    _paragraphFocus.dispose();
    super.dispose();
  }

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
          _buildEditableSummarySection(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      height: 140,
      decoration: _sectionDecoration(),
      child: Row(
        children: [
          _buildHeaderText(),
          _buildProfileCards(),
        ],
      ),
    );
  }

  Widget _buildHeaderText() {
    String headerText = widget.selectedPatient?.patient.name ?? 'Select a patient';
    return Expanded(
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 4),
        child: Text(headerText, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildProfileCards() {
    return Expanded(
      child: SizedBox(
        height: 55,
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: 3,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => _buildProfileCard(index),
        ),
      ),
    );
  }

  Widget _buildProfileCard(int index) {
    IconData iconData;
    String dialogContent;
    switch (index) {
      case 0:
        iconData = Icons.edit;
        dialogContent = 'Edit functionality goes here';
        break;
      case 1:
        iconData = Icons.close;
        dialogContent = 'Send notification to patient or hide lab report?';
        break;
      case 2:
        iconData = Icons.check;
        dialogContent = 'Check functionality goes here';
        break;
      default:
        iconData = Icons.help;
        dialogContent = 'Default action';
    }
    return _profileCardContainer(iconData, dialogContent, index == 1);
  }

  Widget _profileCardContainer(IconData icon, String content, bool showDialog) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 8, 8),
      child: GestureDetector(
        onTap: () => showDialog ? _showDialog(context, content) : null,
        child: Container(
          width: 95,
          height: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFD9D9D9),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: const Color(0xFFE0E3E7), width: 2),
          ),
          child: Center(child: Icon(icon, color: Colors.black)),
        ),
      ),
    );
  }

  Widget _buildPatientProfileSection() {
    return _buildSectionContainer(children: widget.selectedPatient == null ? [Text('No patient selected')] : _buildPatientDetails());
  }

  List<Widget> _buildPatientDetails() {
    var patient = widget.selectedPatient!;
    return [
      Row(
        children: [
          Expanded(child: _buildPatientProfileRow('Patient Profile', _formatPatientInfo(patient))),
          Expanded(child: _buildPatientProfileRow('Anamnesis', patient.patient.history?.text ?? 'No history available')),
        ],
      ),
    ];
  }

  String _formatPatientInfo(LabReportAndPatient patient) {
    return 'Name: ${patient.patient.name}\nBirth Date: ${patient.patient.birthDate}\nWeight: ${patient.patient.history?.weight ?? 'Unknown'}kg\nHeight: ${patient.patient.history?.height ?? 'Unknown'}cm';
  }

  Widget _buildPatientProfileRow(String title, String content) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
      child: Container(
        width: double.infinity,
        decoration: _sectionDecoration(),
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

  Widget _buildEditableSummarySection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _buildBiomarkersSection()),
        _buildParagraphBox(),
      ],
    );
  }

  Widget _buildBiomarkersSection() {
    return widget.selectedPatient == null ? _buildSectionContainer(children: [Text('No biomarker selected')]) : _buildBiomarkersList();
  }

  Widget _buildBiomarkersList() {
    var labandpatient = widget.selectedPatient!;
    return _buildSectionContainer(
      children: labandpatient.labReport.biomarkerValues.values.map((biomarker) => _buildBiomarkerRow(biomarker.name, biomarker.value.toString(), 179, minimumRange: 100)).toList(),
    );
  }

Widget _buildBiomarkerRow(
  String title, 
  String value, 
  double valuePosition, {
  double? minimumRange, 
  double? maximumRange
}) {
  const double rangeSize = 120;
  
  double greenContainerWidth = 70;
  Alignment greenContainerAlignment = Alignment.center;
  double lineLeftPosition;

  if (minimumRange != null && maximumRange != null) {
    // Both ranges are provided
    greenContainerWidth = 70; // Or any other width you desire
    greenContainerAlignment = Alignment.center;

      if (valuePosition>minimumRange && valuePosition<maximumRange) {
        lineLeftPosition = rangeSize / 2 + (greenContainerWidth / (maximumRange - minimumRange)) * (valuePosition - (minimumRange + maximumRange) / 2);
      } else if (valuePosition<minimumRange) {
        lineLeftPosition = 17.5;
      } else if (valuePosition>maximumRange) {
        lineLeftPosition = 107.5;
      } else {
        lineLeftPosition = rangeSize / 2; // Default initialization
      }

  } else if (minimumRange != null) {
    // Only minimumRange is provided
    greenContainerWidth = 90;
    greenContainerAlignment = Alignment.centerRight;

    if (valuePosition>=minimumRange && valuePosition<minimumRange*1.8) {
        lineLeftPosition = 30+greenContainerWidth*((valuePosition-minimumRange)/(minimumRange));
      } else if (valuePosition>=minimumRange*1.8) {
        lineLeftPosition = 112; 
      }  else {
        lineLeftPosition = 17.5;
      } 

  } else if (maximumRange != null) {
    // Only maximumRange is provided
    greenContainerWidth = 90;
    greenContainerAlignment = Alignment.centerLeft;

    if (valuePosition<=maximumRange) {
        lineLeftPosition = greenContainerWidth*(valuePosition/maximumRange);
      } else {
        lineLeftPosition = 107.5;
      } 

  } else {
    // Neither range is provided
    greenContainerWidth = 70; // Default width when no ranges are given
    greenContainerAlignment = Alignment.center;
    lineLeftPosition = rangeSize / 2; // Center the line as a default position
  }

  return Padding(
    padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
    child: Container(
      width: double.infinity,
      decoration: _sectionDecoration(),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 2, 0, 2),
        child: Row(
          children: [
            const SizedBox(height: 100, child: VerticalDivider(width: 24, thickness: 4, indent: 12, endIndent: 12, color: Colors.black)),
            Expanded(child: Padding(padding: const EdgeInsetsDirectional.fromSTEB(8, 12, 16, 12), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title)]))),
            Expanded(child: Text(value)),
            SizedBox(
              width: rangeSize,
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  Container(width: 300, height: 10, decoration: BoxDecoration(color: const Color.fromARGB(255, 221, 221, 221), borderRadius: BorderRadius.circular(10))),
                  Align(
                    alignment: greenContainerAlignment,
                    child: Container(width: greenContainerWidth, height: 10, decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(10))),
                  ),
                  Positioned(
                    left: lineLeftPosition,
                    top: -3,
                    child: Container(width: 2, height: 16, color: Colors.black),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}


  BoxDecoration _sectionDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
    );
  }

  Widget _buildParagraphBox() {
    return GestureDetector(
      onTap: () => setState(() => _paragraphFocus.requestFocus()),
      child: Container(
        width: 330, // Adjust the width as needed
        margin: const EdgeInsetsDirectional.fromSTEB(0, 12, 16, 0),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white, // Background color for the box
          borderRadius: BorderRadius.circular(15), // Rounded corners
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Summary Title', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextFormField(
              focusNode: _paragraphFocus,
              controller: _paragraphController,
              maxLines: null,
              decoration: InputDecoration(
                border: _paragraphFocus.hasFocus ? OutlineInputBorder() : InputBorder.none,
                hintText: 'Tap to edit summary...',
                suffixIcon: const Icon(Icons.edit, size: 20, color: Colors.grey),
              ),
              style: TextStyle(fontSize: 16),
              cursorColor: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog(BuildContext context, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Action Required'),
          content: Text(content),
          actions: <Widget>[
            TextButton(child: const Text('Hide report'), onPressed: () => Navigator.of(context).pop()),
            TextButton(child: const Text('Send to Patient'), onPressed: () => Navigator.of(context).pop()),
          ],
        );
      },
    );
  }

  Widget _buildSectionContainer({required List<Widget> children}) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(children: children),
      ),
    );
  }

}
