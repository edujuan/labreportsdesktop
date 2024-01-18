import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../data/data.dart';
import '../../sidebar/bloc/bloc.dart';
import '../bloc/bloc.dart';

class Header extends StatefulWidget {
  final LabReportAndPatient report;

  const Header({super.key, required this.report});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  late final SidebarBloc _sidebarBloc;
  late final DashboardBloc _bloc;

  Future<void> _approveReport() async {
    final result = await _showDialog(
      context,
      'Report will be sent to user',
    );

    if (result) {
      _bloc.add(ApproveReportEvent(widget.report.labReport.id));
      _sidebarBloc.add(RemoveSelectedReport());
    }
  }

  Future<void> _denyReport() async {
    final result = await _showDialog(
      context,
      'Notify patient to schedule an appointment?',
    );

    if (result) {
      _bloc.add(DenyReportEvent(widget.report.labReport.id, true));
      _sidebarBloc.add(RemoveSelectedReport());
    }
  }

  @override
  void initState() {
    super.initState();

    _sidebarBloc = Provider.of<SidebarBloc>(context, listen: false);
    _bloc = Provider.of<DashboardBloc>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final name = '${widget.report.patient.name}  Webber (W)';

    return BlocBuilder<SidebarBloc, SidebarState>(
      bloc: Provider.of<SidebarBloc>(context),
      builder: (context, state) {
        final isInReviewState = state.showReportsInReview;

        final patient = widget.report.patient;

        final info =
            'Name: ${patient.name}\nBirth Date: ${patient.birthDate.day}/${patient.birthDate.month}/${patient.birthDate.year}\nPhone Number: ${patient.phoneNumber}\nWeight: ${patient.history?.weight ?? 'Unknown'}kg\nHeight: ${patient.history?.height ?? 'Unknown'}cm';

        return Container(
          color: Colors.white,
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 4),
                child: Column(
                  mainAxisSize: MainAxisSize.max, // Make the column occupy all available space
                  mainAxisAlignment: MainAxisAlignment.center, // Align children to the center
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        name,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                    // ... other children if any
                  ],
                ),
              ),
            ),
              SizedBox(
                height: 60,
                child: Row(
                  children: [
                    if (isInReviewState)
                      ActionButton(
                        icon: Icons.close,
                        onTap: _denyReport,
                      ),
                    ActionButton(
                      icon: Icons.check,
                      onTap: _approveReport,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),
        );
      },
    );
  }

  Future<bool> _showDialog(
    BuildContext context,
    String content,
  ) async {
    final result = await showDialog<bool?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Action Required'),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );

    return result ?? false;
  }
}

class ActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const ActionButton({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 8, 8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 95,
          height: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFD9D9D9),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: const Color(0xFFE0E3E7), width: 2),
          ),
          child: Center(child: Icon(icon, color: Colors.black)),
        ),
      ),
    );
  }

}
