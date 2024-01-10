import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../data/data.dart';
import 'bloc/bloc.dart';
import 'widgets/widgets.dart';

class SidebarWidget extends StatefulWidget {
  const SidebarWidget({super.key});

  @override
  State<SidebarWidget> createState() => _SidebarWidgetState();
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

        return ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: 250,
            maxWidth: 250,
          ),
          child: Column(
            children: [
              Toggles(state),
              const SizedBox(height: 20),
              if (displayList.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: displayList.length,
                    itemBuilder: (context, index) {
                      final e = displayList[index];
                      return SidebarItem(
                        onTap: () {
                          _bloc.add(
                              SelectReportEvent(index, displayList[index]));
                        },
                        isSelected: state.selectedIndex == index,
                        name: e.patient.name,
                        birthDate: e.patient.birthDate,
                        date: e.labReport.reportDate,
                      );
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
