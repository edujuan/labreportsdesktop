import 'package:flutter/material.dart';
import 'package:lab4_doctors/core/dependencies.dart';
import 'package:lab4_doctors/dashboard/dashboard.dart';
import 'package:lab4_doctors/sidebar/side_bar.dart';
import 'data/data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {


  MyApp({super.key}); 

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return const DependenciesScope(
      child: MaterialApp(
          title: 'Health Report',
          home: Scaffold(
          
            body: Row(
              children: [
                SidebarWidget(),
                Expanded(child: Dashboard5Widget()),
              ],
            ),),        
      ),
    );
  }
}
