import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../dashboard/bloc/bloc.dart';
import '../data/data.dart';
import '../sidebar/bloc/bloc.dart';

class DependenciesScope extends StatefulWidget {
  final Widget child;

  const DependenciesScope({super.key, required this.child});

  @override
  State<DependenciesScope> createState() => _DependenciesScopeState();
}

class _DependenciesScopeState extends State<DependenciesScope> {
  late final ApiClient _client;

  late final DashboardBloc _dashboardBloc;
  late final SidebarBloc _sidebarBloc;

  late final User _user;

  @override
  void initState() {
    super.initState();

    _client = ApiClient(
      baseUrl: 'localhost:8080',
      httpClient: http.Client(),
    );

    _dashboardBloc = DashboardBloc(client: _client);
    _sidebarBloc = SidebarBloc(client: _client)
      ..add(FetchReportsInReviewEvent());

    // Mock Data
    _user = const User(
      id: 'some-unique-uuid',
      name: 'Annabell',
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<User>(create: (context) => _user),
        Provider<DashboardBloc>(create: (context) => _dashboardBloc),
        Provider<SidebarBloc>(create: (context) => _sidebarBloc),
      ],
      child: widget.child,
    );
  }
}
