import 'package:flutter/material.dart';
import 'package:lab4_doctors/dashboard.dart';
import 'package:lab4_doctors/sideebr_widget.dart';
import 'classes.dart'; // Make sure this package is added in your pubspec.yaml file

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {


  MyApp({super.key}); 

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  LabReportAndPatient? selectedPatient;

  void setSelectedLabReportAndPatient(LabReportAndPatient patient) {
    setState(() {
      selectedPatient = patient;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Health Report',
        home: Scaffold(
        
          body: Row(
            children: [
              SidebarWidget(setSelectedLabReportAndPatient:setSelectedLabReportAndPatient),
              Expanded(child: Dashboard5Widget(
                  setSelectedLabReportAndPatient:setSelectedLabReportAndPatient,
                  selectedPatient:selectedPatient,
                  )),
            ],
          ),),        
    );
  }
}
