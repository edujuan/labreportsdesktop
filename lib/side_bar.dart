import 'package:flutter/material.dart';
import 'biomarker.dart';
import 'classes.dart'; // Assuming this is where LabReportAndPatient, LabReportDto, PatientHistory, Patient are defined

class SidebarWidget extends StatefulWidget {
  final Function(LabReportAndPatient) setSelectedLabReportAndPatient;
  const SidebarWidget({required this.setSelectedLabReportAndPatient, Key? key}) : super(key: key);

  @override
  _SidebarWidgetState createState() => _SidebarWidgetState();
}

class _SidebarWidgetState extends State<SidebarWidget> {
  int _selectedIndex = 0;
  bool showYes = false; // Toggle between showing "Yes" or "No"

  final List<LabReportAndPatient> yesLabReports = [];
  final List<LabReportAndPatient> noLabReports = [];

  @override
  void initState() {
    super.initState();

    // Mock data initialization
    for (int i = 0; i < 8; i++) {
      var labReport = LabReportDto(
        id: 'lab-report-id-$i',
        name: 'Blood test $i',
        reportDate: DateTime.now(),
        // Assuming you have a Map<String, Biomarker> for biomarkerValues
        biomarkerValues: <String, Biomarker>{
            "Test 1": const Biomarker(
                id: "",
                name: "Test 1",
                bucket: "Bucket 1",
                value: 2,
                minValue: 1,
                maxValue: 3,
                unit: "unit",
                biomarkerDescription: "Description",
                rangeDescription: "Range Desc"),
            "Test 2": const Biomarker(
                id: "",
                name: "Test 2",
                bucket: "Bucket 1",
                value: 2,
                minValue: 1,
                maxValue: 3,
                unit: "unit",
                biomarkerDescription: "Description",
                rangeDescription: "Range Desc"),
            "Test 3": const Biomarker(
                id: "",
                name: "Test 3",
                bucket: "Bucket 2",
                value: 2,
                minValue: 1,
                maxValue: 3,
                unit: "unit",
                biomarkerDescription: "Description",
                rangeDescription: "Range Desc")
          }, // Replace with actual biomarker values
        patientId: 'patient-id-$i',
        executiveSummary: "Executive summary of lab report $i",
        recommendations: "Recommendations based on lab report $i",
        doctorName: "Dr. Smith $i",
      );

      var patientHistory = PatientHistory(
        text: "Patient $i has a history of...",
        weight: 70 + i,
        height: 175 + i,
      );

      var patient = Patient(
        name: "John Doe $i",
        history: patientHistory,
        birthDate: DateTime(1985, 5, 20).add(Duration(days: i * 365)),
      );

      // Example condition for Yes or No categorization
      if (i % 2 == 0) { // Arbitrary condition: even indices are 'Yes', odd are 'No'
        yesLabReports.add(LabReportAndPatient(labReport: labReport, patient: patient));
      } else {
        noLabReports.add(LabReportAndPatient(labReport: labReport, patient: patient));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<LabReportAndPatient> displayList = showYes ? yesLabReports : noLabReports;

    return Column(
      children: [
        Switch(
          value: showYes,
          onChanged: (value) {
            setState(() {
              showYes = value;
              _selectedIndex = 0; // Reset selection when toggling
            });
          },
        ),
        Expanded(
          child: NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
              widget.setSelectedLabReportAndPatient(displayList[index]);
            },
            labelType: NavigationRailLabelType.all,
            destinations: displayList
                .map((e) => buildNavigationDestination(
                    e.patient.name, e.labReport.reportDate.toString(), "All Healthy", displayList.indexOf(e)))
                .toList(),
          ),
        ),
      ],
    );
  }

  NavigationRailDestination buildNavigationDestination(String name, String date, String results, int index) {
    bool isSelected = _selectedIndex == index;

    return NavigationRailDestination(
      icon: Card(
        color: isSelected ? Colors.black : Colors.white,
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              Icon(Icons.person_outline, color: isSelected ? Colors.white : Colors.black),
              SizedBox(width: 8),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: $name', style: TextStyle(color: isSelected ? Colors.white : Colors.black)),
                  Text('Date: $date', style: TextStyle(color: isSelected ? Colors.white : Colors.black)),
                  Text('Results: $results', style: TextStyle(color: isSelected ? Colors.white : Colors.black)),
                ],
              ),
            ],
          ),
        ),
      ),
      label: const SizedBox(),
    );
  }
}
