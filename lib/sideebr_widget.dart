import 'package:flutter/material.dart';
import 'biomarker.dart';
import 'classes.dart'; // Assuming this is the file where LabReportAndPatient is defined

class SidebarWidget extends StatefulWidget {
  final Function(LabReportAndPatient) setSelectedLabReportAndPatient;
  const SidebarWidget({required this.setSelectedLabReportAndPatient, Key? key}) : super(key: key);

  @override
  _SidebarWidgetState createState() => _SidebarWidgetState();
}

class _SidebarWidgetState extends State<SidebarWidget> {
  int _selectedIndex = 0;

  // Create mock Biomarkers
  final Map<String, Biomarker> biomarkers = {
    "Test 1": const Biomarker(
      id: "biomarker-id-1",
      name: "Test 1",
      bucket: "Bucket 1",
      value: 2,
      minValue: 1,
      maxValue: 3,
      unit: "unit",
      biomarkerDescription: "Description for Test 1",
      rangeDescription: "Range Description for Test 1",
    ),
    // ... add other biomarkers
  };

  // Create a list of LabReportAndPatient instances
  final List<LabReportAndPatient> labReportsAndPatients = [];

  @override
  void initState() {
    super.initState();
    // Populate the list with LabReportAndPatient instances
    for (int i = 0; i < 4; i++) { // Assuming you have 4 navigation destinations
      var labReport = LabReportDto(
        id: 'lab-report-id-$i',
        name: 'Blood test $i',
        reportDate: DateTime.now(),
        biomarkerValues: biomarkers,
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

      labReportsAndPatients.add(LabReportAndPatient(labReport: labReport, patient: patient));
    }
  }

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: _selectedIndex,
      onDestinationSelected: (int index) {
        setState(() {
          _selectedIndex = index;
        });
        if (index < labReportsAndPatients.length) {
          widget.setSelectedLabReportAndPatient(labReportsAndPatients[index]);
        }
      },
      labelType: NavigationRailLabelType.all,
      destinations: [
        buildNavigationDestination("Müller, Thomas", "07.12.2023", "All Healthy", 0),
        buildNavigationDestination("Neuer, Manuel", "07.12.2023", "All Healthy", 1),
        buildNavigationDestination("Kimmich, Joshua", "08.12.2023", "All Healthy", 2),
        buildNavigationDestination("Juan, Viera", "08.12.2023", "All Healthy", 2),
        // Add more destinations here as needed
      ],
    );
  }

  NavigationRailDestination buildNavigationDestination(String name, String date, String results, int index) {
    bool isSelected = _selectedIndex == index;

    return NavigationRailDestination(
      icon:  
      Card(
        color: isSelected ? Colors.black : Colors.white,
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
      Icon(Icons.person_outline, color: isSelected ? Colors.white : Colors.black),
             
              SizedBox(width: 8), // Space between icon and text
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
      
      
      label: const SizedBox()
    );
  }
}
