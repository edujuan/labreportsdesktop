// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../data/data.dart';
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

  final TextEditingController _newBoxController = TextEditingController();
  final FocusNode _newBoxFocus = FocusNode(); 

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
    _newBoxController.dispose(); // Add this line
    _newBoxFocus.dispose();     // Add this line
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [ 
          _buildHeaderText(selectedReport),
          _buildProfileCards(selectedReport),
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

  Widget _buildProfileCards(LabReportAndPatient? selectedReport) {
    return Expanded(
      child: SizedBox(
        height: 55,
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: 3,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => _buildProfileCard(index, selectedReport),
        ),
      ),
    );
  }

  Widget _buildProfileCard(int index, LabReportAndPatient? selectedReport) {
    IconData iconData;
    String dialogContent;
    switch (index) {
      case 0:
        iconData = Icons.edit;
        dialogContent = 'Edit functionality goes here';
        break;
      case 1:
        iconData = Icons.close;
        dialogContent = 'Notify patient to schedule an appointment?';
        break;
      case 2:
        iconData = Icons.check;
        dialogContent = 'Check functionality goes here';
        break;
      default:
        iconData = Icons.help;
        dialogContent = 'Default action';
    }
    return _profileCardContainer(iconData, dialogContent, index == 1, selectedReport);
  }

  Widget _profileCardContainer(IconData icon, String content, bool showDialog, LabReportAndPatient? selectedReport) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 8, 8),
      child: GestureDetector(
        onTap: () => {
          if(showDialog) {
            _showDialog(context, content, selectedReport)
          } else if(icon == Icons.check && selectedReport != null) {
            _bloc.add(ApproveReportEvent(selectedReport.labReport.id)),
            _sidebarBloc.add(RemoveSelectedReport())
          }
        },
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
  return LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) {
      final double biomarkersMinWidth = 500; // Set your minimum width here
      final double availableWidth = constraints.maxWidth;
      final double biomarkersWidth = (availableWidth > biomarkersMinWidth)
          ? biomarkersMinWidth
          : availableWidth;

      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: biomarkersWidth,
            child: _buildBiomarkersSection(selectedReport),
          ),
          if (selectedReport != null)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildParagraphBox(selectedReport.labReport),
                  _buildNewBox(),
                ],
              ),
            ),
        ],
      );
    },
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
      children: labandpatient.labReport.biomarkerValues.values.map((biomarker) => _buildBiomarkerRow(biomarker.name, biomarker.value.toString(), 300, minimumRange: 100, maximumRange: 300)).toList(),
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
  
  double greenContainerWidth = rangeSize*0.75;
  double greenStart = (1-(greenContainerWidth/rangeSize))*rangeSize;
  double expansionRation = 1.1;


  // Alignment greenContainerAlignment = Alignment.center;      
  Offset offsetValue = Offset(0,0);
  double lineLeftPosition;
  Color lineColor = Colors.green;

  if (minimumRange != null && maximumRange != null) {
    // Both ranges are provided
    greenContainerWidth = greenContainerWidth; // Or any other width you desire
    offsetValue = Offset(0,0);

      if (valuePosition>minimumRange && valuePosition<=maximumRange) {
        lineLeftPosition = rangeSize / 2 + (greenContainerWidth / (maximumRange - minimumRange)) * (valuePosition - (minimumRange + maximumRange) / 2);
      } else if (valuePosition<minimumRange) {
        lineLeftPosition = ((1-(greenContainerWidth/rangeSize))/3)*rangeSize;
        lineColor = Colors.red;
      } else if (valuePosition>maximumRange) {
        lineLeftPosition = (1-((1-(greenContainerWidth/rangeSize))/3))*rangeSize;
        lineColor = Colors.red;
      } else {
        lineLeftPosition = rangeSize / 2; // Default initialization
        lineColor = Colors.green;
      }

  } else if (minimumRange != null) {
    // Only minimumRange is provided
    greenContainerWidth = greenContainerWidth*expansionRation;
    greenStart = (1-(greenContainerWidth/rangeSize))*rangeSize;
    // greenContainerAlignment = Alignment.centerRight;
    offsetValue = Offset(10,0);


    if (valuePosition>=minimumRange && valuePosition<minimumRange*1.8) {
        lineLeftPosition = greenStart+greenContainerWidth*((valuePosition-minimumRange)/(minimumRange));
      } else if (valuePosition>=minimumRange*1.8) {
        lineLeftPosition = rangeSize*0.95; 
        lineColor = Colors.red;
      }  else {
        lineLeftPosition = ((1-(greenContainerWidth/rangeSize))/2)*rangeSize;
      } 

  } else if (maximumRange != null) {
    // Only maximumRange is provided
    greenContainerWidth = greenContainerWidth*expansionRation;
    offsetValue = Offset(-10,0);

    if (valuePosition<=maximumRange) {
        lineLeftPosition = greenContainerWidth*(valuePosition/maximumRange);
      } else {
        lineColor = Colors.red;
        lineLeftPosition = (1-((1-(greenContainerWidth/rangeSize))/2))*rangeSize;
      } 

  } else {
    // Neither range is provided
    greenContainerWidth = greenContainerWidth; // Default width when no ranges are given
    // greenContainerAlignment = Alignment.center;
    offsetValue = Offset(0,0);
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
            SizedBox(height: 100, child: VerticalDivider(width: 24, thickness: 4, indent: 12, endIndent: 12, color: lineColor)),
            Expanded(child: Padding(padding: const EdgeInsetsDirectional.fromSTEB(8, 12, 16, 12), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title)]))),
            Expanded(child: Text(value)),
            SizedBox(
              width: rangeSize,
              height: 40, // Increased height to accommodate labels at the bottom
              child: Stack(
                alignment: Alignment.topCenter,
                clipBehavior: Clip.none,
                children: [
                  // Grey background container
                  Container(
                    width: rangeSize,
                    height: 10,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 221, 221, 221),
                      borderRadius: BorderRadius.circular(10)),
                  ),
                  // Green range container
                  Transform.translate(
                    offset: offsetValue,
                    child: Container(
                      width: greenContainerWidth,
                      height: 10,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  ),
                  // Black line indicator
                  Positioned(
                    left: lineLeftPosition,
                    top: -3,
                    child: Container(
                      width: 2,
                      height: 16,
                      color: Colors.black),
                  ),
                  // Conditionally add labels at the bottom
                  if (minimumRange != null)
                    Positioned(
                      left: 10, // Adjust as needed
                      top: 15,
                      bottom: 0,
                      child: Text(minimumRange.toString(), style: TextStyle(fontSize: 12)),
                    ),
                  if (maximumRange != null)
                    Positioned(
                      right: 10, // Adjust as needed
                      top: 15,
                      bottom: 0,
                      child: Text(maximumRange.toString(), style: TextStyle(fontSize: 12)),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    )
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
  



  Widget _buildNewBox() {
    return GestureDetector(
      onTap: () => setState(() => _newBoxFocus.requestFocus()),
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
            const Text('Recommendations',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              focusNode: _newBoxFocus,
              controller: _newBoxController,
              onSubmitted: (value) {
                // Add your submission logic here
              },
              maxLines: null,
              decoration: InputDecoration(
                border: _newBoxFocus.hasFocus
                    ? OutlineInputBorder()
                    : InputBorder.none,
                hintText: 'Tap to edit...',
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










  void _showDialog(BuildContext context, String content, LabReportAndPatient? selectedReport) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Action Required'),
          content: Text(content),
          actions: <Widget>[
            TextButton(
                child: const Text('No'),
                onPressed: () => {
                  if(selectedReport != null) {
                    _bloc.add(DenyReportEvent(selectedReport.labReport.id, false)),
                    _sidebarBloc.add(RemoveSelectedReport())
                  },
                  Navigator.of(context).pop()
                }),
            TextButton(
                child: const Text('Yes'),
                onPressed: () => {
                  if(selectedReport != null) {
                    _bloc.add(DenyReportEvent(selectedReport.labReport.id, true)),
                    _sidebarBloc.add(RemoveSelectedReport())
                  },
                  Navigator.of(context).pop()
                }),
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
