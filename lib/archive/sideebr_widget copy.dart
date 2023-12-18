import 'package:flutter/material.dart';

class SideebrWidget extends StatefulWidget {
  const SideebrWidget({Key? key}) : super(key: key);

  @override
  _SideebrWidgetState createState() => _SideebrWidgetState();
}

class _SideebrWidgetState extends State<SideebrWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      constraints: BoxConstraints(maxWidth: 300),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Color(0xFFE5E7EB), offset: Offset(1, 0))],
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSearchBox(),
              buildPatientProfile("Müller, Thomas", "07.12.2023", "All Healthy", Color(0xFF216A6D)),
              buildPatientProfile("Neuer, Manuel", "07.12.2023", "All Healthy", Colors.white),
              buildPatientProfile("Kimmich, Joshua", "08.12.2023", "All Healthy", Colors.white),
              // You can add more widgets here as needed
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSearchBox() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFF1F4F8),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Padding(
          padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.search_rounded, color: Color(0xFF606A85), size: 28),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                child: Text('Search'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPatientProfile(String name, String date, String results, Color bgColor) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: bgColor,
          boxShadow: [BoxShadow(blurRadius: 4, color: Color(0x33000000), offset: Offset(0, 2))],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                    child: Text('Name: $name'),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                    child: Text('Date: $date'),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                    child: Text('Results: $results'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
