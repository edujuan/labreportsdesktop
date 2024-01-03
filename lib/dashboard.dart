import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'data/data.dart';
import 'package:lab4_doctors/dashboard/bloc/bloc.dart';
import 'package:lab4_doctors/sidebar/bloc/bloc.dart';

class Dashboard5Widget extends StatefulWidget {
  const Dashboard5Widget({super.key});

  @override
  _Dashboard5WidgetState createState() => _Dashboard5WidgetState();
}

class _Dashboard5WidgetState extends State<Dashboard5Widget>
    with TickerProviderStateMixin {
  final TextEditingController _paragraphController = TextEditingController();
  final FocusNode _paragraphFocus = FocusNode();

  late final SidebarBloc _sidebarBloc;
  late final DashboardBloc _bloc;

  @override
  void initState() {
    super.initState();

    _sidebarBloc = Provider.of<SidebarBloc>(context, listen: false);
    _bloc = Provider.of<DashboardBloc>(context, listen: false);
  }

  void _updateExecutiveSummaryController(String executiveSummary) {
    _paragraphController.text = executiveSummary;
  }

  @override
  void dispose() {
    _paragraphController.dispose();
    _paragraphFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SidebarBloc, SidebarState>(
        bloc: _sidebarBloc,
        builder: (sidebarContext, sidebarState) {
          if (sidebarState.selectedLabReport != null) {
            _updateExecutiveSummaryController(
                sidebarState.selectedLabReport!.labReport.executiveSummary);
          }
          return BlocBuilder<DashboardBloc, DashboardState>(
              bloc: _bloc,
              builder: (dashboardContext, dashboardState) {
                return Scaffold(
                  backgroundColor: const Color(0xFFF1F4F8),
                  body: SafeArea(
                    child: Row(
                      children: [
                        Expanded(
                            child: _buildDashboardContent(
                                sidebarState.selectedLabReport))
                      ],
                    ),
                  ),
                );
              });
        });
  }

  Widget _buildDashboardContent(LabReportAndPatient? selectedReport) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeader(selectedReport),
          _buildPatientProfileSection(selectedReport),
          _buildEditableSummarySection(selectedReport),
        ],
      ),
    );
  }

  Widget _buildHeader(LabReportAndPatient? selectedReport) {
    return Container(
      width: double.infinity,
      height: 140,
      decoration: _sectionDecoration(),
      child: Row(
        children: [
          _buildHeaderText(selectedReport),
          _buildProfileCards(),
        ],
      ),
    );
  }

  Widget _buildHeaderText(LabReportAndPatient? selectedReport) {
    String headerText = selectedReport?.patient.name ?? 'Select a patient';
    return Expanded(
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 4),
        child: Text(headerText,
            style: const TextStyle(fontWeight: FontWeight.bold)),
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

  Widget _buildPatientProfileSection(LabReportAndPatient? selectedReport) {
    return _buildSectionContainer(
        children: selectedReport == null
            ? [Text('No patient selected')]
            : _buildPatientDetails(selectedReport));
  }

  List<Widget> _buildPatientDetails(LabReportAndPatient? selectedReport) {
    var patient = selectedReport!;
    return [
      Row(
        children: [
          Expanded(
              child: _buildPatientProfileRow(
                  'Patient Profile', _formatPatientInfo(patient))),
          Expanded(
              child: _buildPatientProfileRow('Anamnesis',
                  patient.patient.history?.text ?? 'No history available')),
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

  Widget _buildEditableSummarySection(LabReportAndPatient? selectedReport) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
            Expanded(child: _buildBiomarkersSection(selectedReport)),
          ] +
          (selectedReport != null
              ? [_buildParagraphBox(selectedReport.labReport)]
              : <Widget>[]),
    );
  }

  Widget _buildBiomarkersSection(LabReportAndPatient? selectedReport) {
    return selectedReport == null
        ? _buildSectionContainer(children: [Text('No biomarker selected')])
        : _buildBiomarkersList(selectedReport);
  }

  Widget _buildBiomarkersList(LabReportAndPatient selectedReport) {
    var labandpatient = selectedReport;
    return _buildSectionContainer(
      children: labandpatient.labReport.biomarkerValues.values
          .map((biomarker) => _buildBiomarkerRow(
              biomarker.name, biomarker.value.toString(), 18))
          .toList(),
    );
  }

  Widget _buildBiomarkerRow(String title, String value, double valuePosition) {
    const double blackContainerHeight = 20;
    const double redLineHeight = 30; // This is taller than the black container

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
                      color: Colors.black)),
              Expanded(
                  child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(8, 12, 16, 12),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [Text(title)]))),
              Expanded(child: Text(value)),
              Expanded(
                child: Stack(
                  clipBehavior:
                      Clip.none, // Allow children to draw outside of the stack
                  alignment: Alignment.center,
                  children: [
                    Container(
                        width: 300,
                        height: blackContainerHeight,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10))),
                    Container(
                        width: 290,
                        height: 10,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10))),
                    Positioned(
                      left: 50, // Adjust this based on the value
                      child: OverflowBox(
                        minWidth: 4,
                        maxWidth: 4,
                        minHeight: redLineHeight,
                        maxHeight: redLineHeight,
                        alignment: Alignment.center,
                        child: Container(
                            width: 4,
                            height: redLineHeight,
                            color: Colors
                                .red), // This is the line indicating the value
                      ),
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

  Widget _buildParagraphBox(Report selectedReport) {
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
            const Text('Summary Title',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              focusNode: _paragraphFocus,
              controller: _paragraphController,
              onSubmitted: (value) =>
                  _bloc.add(EditReportEvent(selectedReport.id, summary: value)),
              maxLines: null,
              decoration: InputDecoration(
                border: _paragraphFocus.hasFocus
                    ? OutlineInputBorder()
                    : InputBorder.none,
                hintText: 'Tap to edit summary...',
                suffixIcon:
                    const Icon(Icons.edit, size: 20, color: Colors.grey),
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
            TextButton(
                child: const Text('Hide report'),
                onPressed: () => Navigator.of(context).pop()),
            TextButton(
                child: const Text('Send to Patient'),
                onPressed: () => Navigator.of(context).pop()),
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
