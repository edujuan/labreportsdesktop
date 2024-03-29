import 'package:flutter/material.dart';
import 'package:lab4_doctors/src/core/theme.dart';

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
    return DependenciesScope(
      child: MaterialApp(
        title: 'Health Report',
        theme: theme,
        home: const Scaffold(
          body: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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
