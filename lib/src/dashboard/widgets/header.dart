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
      'Please confirm your decision to send the report to the patient',
    );

    if (result) {
      _bloc.add(ApproveReportEvent(widget.report.labReport.id));
      _sidebarBloc.add(RemoveSelectedReport());
    }
  }

  Future<void> _denyReport(String phoneNumber) async {
    final result = await _showDialog(context,
        'Please confirm your decision not to send the report to the patient at this time.\n\nPatient Contact Number: $phoneNumber\nConsider calling the patient to arrange an appointment.');

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
    return BlocBuilder<SidebarBloc, SidebarState>(
      bloc: Provider.of<SidebarBloc>(context),
      builder: (context, state) {
        final isInReviewState = state.showReportsInReview;

        final patient = widget.report.patient;

        final name = '${patient.name} (${patient.gender})';

        final age =
            'Age: ${(DateTime.now().difference(patient.birthDate).inDays / 365.25).floor()}';

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                child: Center(
                  child: Text(
                    name[0],
                    style: const TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                name,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(age),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isInReviewState) ...[
                    ActionButton(
                      icon: Icons.close,
                      onTap: () => _denyReport(patient.phoneNumber),
                    ),
                    const SizedBox(width: 20)
                  ],
                  ActionButton(
                    icon: Icons.check,
                    onTap: _approveReport,
                  ),
                ],
              ),
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

  const ActionButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color: const Color(0xFFD9D9D9),
          borderRadius: BorderRadius.circular(70),
          border: Border.all(color: const Color(0xFFE0E3E7), width: 2),
        ),
        child: Center(
          child: Icon(
            icon,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
