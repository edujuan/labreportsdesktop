import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab4_doctors/sidebar/bloc/bloc.dart';
import 'package:provider/provider.dart';
import 'data/data.dart';

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
        if(state.status == SidebarStatus.initial){
          return const Text("Loading...");
        }
        if(state.status == SidebarStatus.failure){
          return const Text("Error...");
        }

        List<LabReportAndPatient> displayList = state.showReportsInReview ? state.inReviewLabReports : state.deniedLabReports;

        return Column(
          children: [
            Switch(
              value: state.showReportsInReview,
              onChanged: (value) {
                _bloc.add(SwitchReportTabEvent(value));
                if(value) {
                  _bloc.add(FetchReportsInReviewEvent());
                } else {
                  _bloc.add(FetchDeniedReportsEvent());
                }
              },
            ),
            Expanded(
              child: NavigationRail(
                selectedIndex: state.selectedIndex,
                onDestinationSelected: (int index) {
                  _bloc.add(SelectReportEvent(index, displayList[index]));
                },
                labelType: NavigationRailLabelType.all,
                destinations: displayList
                  .map((e) => buildNavigationDestination(
                      e.patient.name, e.labReport.reportDate.toString(), "All Healthy", displayList.indexOf(e), state.selectedIndex
                  )).toList(),
              ),
            ),
          ],
        );
      }
    );


  }

  NavigationRailDestination buildNavigationDestination(String name, String date, String results, int index, int selectedIndex) {
    bool isSelected = selectedIndex == index;

    return NavigationRailDestination(
      icon: Card(
        color: isSelected ? Colors.black : Colors.white,
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              Icon(Icons.person_outline, color: isSelected ? Colors.white : Colors.black),
              SizedBox(width: 8),
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
      label: const SizedBox(),
    );
  }
}
