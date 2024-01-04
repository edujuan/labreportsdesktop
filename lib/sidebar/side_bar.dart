import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab4_doctors/sidebar/bloc/bloc.dart';
import 'package:provider/provider.dart';
import '../data/data.dart';

class SidebarWidget extends StatefulWidget {
  const SidebarWidget({super.key});

  @override
  _SidebarWidgetState createState() => _SidebarWidgetState();
}

class _SidebarWidgetState extends State<SidebarWidget> {
  late final SidebarBloc _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = Provider.of<SidebarBloc>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SidebarBloc, SidebarState>(
        bloc: _bloc,
        builder: (context, state) {
          if (state.status == SidebarStatus.failure) {
            return const SizedBox(width: 200, child: Text("Error..."));
          }
          if (state.status == SidebarStatus.initial) {
            return const SizedBox(width: 200, child: Text("Loading..."));
          }

          List<LabReportAndPatient> displayList = state.showReportsInReview
              ? state.inReviewLabReports
              : state.deniedLabReports;
          
          return Container(
            constraints: BoxConstraints(minWidth: 230), // Set minimum width here
            child: Column(         
            children: [
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: ToggleButtons(
                isSelected: [state.showReportsInReview, !state.showReportsInReview],
                onPressed: (int index) {
                  _bloc.add(SwitchReportTabEvent(index == 0));
                },
                borderRadius: BorderRadius.circular(10),
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('In Review'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Denied'),
                  ),
                ],
              ),
              ),
              Expanded(
                child: displayList.length < 2
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: displayList
                            .map(
                              (e) => buildNavigationDestination(
                                  e.patient.name,
                                  e.labReport.reportDate.toString(),
                                  "All Healthy",
                                  0,
                                  0),
                            )
                            .toList(),
                      )
                    : NavigationRail(
                        selectedIndex: state.selectedIndex,
                        onDestinationSelected: (int index) {
                          _bloc.add(
                              SelectReportEvent(index, displayList[index]));
                        },
                        labelType: NavigationRailLabelType.all,
                        destinations: displayList
                            .map(
                              (e) => NavigationRailDestination(
                                  icon: buildNavigationDestination(
                                      e.patient.name,
                                      e.labReport.reportDate.toString(),
                                      "All Healthy",
                                      displayList.indexOf(e),
                                      state.selectedIndex),
                                  label: const SizedBox()),
                            )
                            .toList(),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildNavigationDestination(
      String name, String date, String results, int index, int selectedIndex) {
    bool isSelected = selectedIndex == index;

    return Card(
      color: isSelected ? Colors.black : Colors.white,
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Icon(Icons.person_outline,
                color: isSelected ? Colors.white : Colors.black),
            SizedBox(width: 8),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: $name',
                    style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black)),
                Text('Date: $date',
                    style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black)),
                Text('Results: $results',
                    style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
