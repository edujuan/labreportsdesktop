import 'package:flutter/material.dart';

import 'core/dependencies.dart';
import 'dashboard/dashboard.dart';
import 'sidebar/side_bar.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return const DependenciesScope(
      child: MaterialApp(
        title: 'Health Report',
        home: Scaffold(
          body: Row(
            children: [
              SidebarWidget(),
              Expanded(child: DashboardWidget()),
            ],
          ),
        ),
      ),
    );
  }
}
