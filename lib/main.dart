import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:lab4_doctors/dashboard.dart';
import 'package:lab4_doctors/sideebr_widget.dart'; // Make sure this package is added in your pubspec.yaml file

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
        title: 'Health Report',
        home: Scaffold(
        
          
          body: Row(
            children: [
              SidebarWidget(),
              Expanded(child: Dashboard5Widget()),
            ],
          ),),        
          // Dashboard5Widget(),
    );
  }
}


class HealthReportScreen extends StatelessWidget {
  final List<Patient> patientData = [
    Patient('Leonardo', 'Normal'),
    Patient('Cristiano', 'Normal'),
    Patient('Ken', 'High Sugar'),
    // ... other patients
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health Report'),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: ListView.builder(
              itemCount: patientData.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(patientData[index].name),
                    trailing: Text(
                      patientData[index].result,
                      style: TextStyle(
                        color: patientData[index].result == 'High Sugar' ? Colors.red : Colors.green,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Card(
                  margin: EdgeInsets.all(8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Executive Summary:',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'This report details the results of a comprehensive blood test analysis conducted to evaluate a range of hematological parameters...',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        SizedBox(height: 20),
                        // Mock Pie Chart
                        SizedBox(
                          height: 200,
                          child: PieChart(
                            PieChartData(
                              sections: [
                                PieChartSectionData(
                                  value: 30,
                                  color: Colors.blue,
                                  title: 'RBC',
                                ),
                                PieChartSectionData(
                                  value: 20,
                                  color: Colors.yellow,
                                  title: 'WBC',
                                ),
                                // Add more sections as needed
                              ],
                            ),
                          ),
                        ),
                        // Mock Line Chart
                        SizedBox(
                          height: 200,
                          child: LineChart(
                            LineChartData(
                              gridData: FlGridData(show: false),
                              titlesData: FlTitlesData(show: false),
                              borderData: FlBorderData(show: false),
                              lineBarsData: [
                                LineChartBarData(
                                  spots: [
                                    FlSpot(0, 1),
                                    FlSpot(1, 3),
                                    // Add more spots as needed
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Patient {
  final String name;
  final String result;

  Patient(this.name, this.result);
}


// Mock data for the patients
List<Patient> patientData = [
  Patient('Leonardo', 'Normal'),
  Patient('Cristiano', 'Normal'),
  Patient('Ken', 'High Sugar'),
  // ... other patients
];