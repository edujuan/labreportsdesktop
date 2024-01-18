import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../bloc/bloc.dart';

class Toggles extends StatelessWidget {
  final SidebarState state;

  const Toggles(this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<SidebarBloc>(context);

    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: ToggleButtons(
        selectedColor: Colors.white,
        fillColor: const Color(0XFF246A6D),
        isSelected: [state.showReportsInReview, !state.showReportsInReview],
        onPressed: (int index) {
          bloc.add(SwitchReportTabEvent(index == 0));
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
    );
  }
}
