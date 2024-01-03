// import 'package:uuid/uuid.dart';

// // Assuming your Biomarker and other related classes are defined as provided

// void main() {
//   // Create mock Biomarkers
//   var biomarkers = <String, Biomarker>{
//     "Test 1": Biomarker(
//       id: "biomarker-id-1",
//       name: "Test 1",
//       bucket: "Bucket 1",
//       value: 2,
//       minValue: 1,
//       maxValue: 3,
//       unit: "unit",
//       biomarkerDescription: "Description for Test 1",
//       rangeDescription: "Range Description for Test 1",
//     ),
//     "Test 2": Biomarker(
//       id: "biomarker-id-2",
//       name: "Test 2",
//       bucket: "Bucket 1",
//       value: 5,
//       minValue: 3,
//       maxValue: 7,
//       unit: "unit",
//       biomarkerDescription: "Description for Test 2",
//       rangeDescription: "Range Description for Test 2",
//     ),
//     "Test 3": Biomarker(
//       id: "biomarker-id-3",
//       name: "Test 3",
//       bucket: "Bucket 2",
//       value: 4,
//       minValue: 2,
//       maxValue: 6,
//       unit: "unit",
//       biomarkerDescription: "Description for Test 3",
//       rangeDescription: "Range Description for Test 3",
//     ),
//   };

//   // Create a LabReportDto
//   var labReport = LabReportDto(
//     id: 'lab-report-id-1',
//     name: 'Blood test 1',
//     reportDate: DateTime.now(),
//     biomarkerValues: biomarkers,
//     patientId: 'patient-id-1',
//     executiveSummary: "This is the executive summary of the lab report.",
//     recommendations: "These are the recommendations based on the lab report.",
//     doctorName: "Dr. Smith",
//   );

//   // Create a PatientHistory
//   var patientHistory.dart = PatientHistory(
//     text: "Patient has a history of...",
//     weight: 70,
//     height: 175,
//   );

//   // Create a Patient
//   var patient = Patient(
//     name: "John Doe",
//     history: patientHistory.dart,
//     birthDate: DateTime(1985, 5, 20),
//   );

//   // Finally, create LabReportAndPatient
//   var labReportAndPatient = LabReportAndPatient(labReport: labReport, patient: patient);

//   // Example of how to access some data
//   print("Lab Report Name: ${labReportAndPatient.labReport.name}");
//   print("Patient Name: ${labReportAndPatient.patient.name}");
// }
