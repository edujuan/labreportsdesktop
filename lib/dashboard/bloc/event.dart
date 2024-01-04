part of 'bloc.dart';

sealed class DashboardEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class EditReportEvent extends DashboardEvent {
  final String id;
  final String? summary, recommendation;

  EditReportEvent(this.id, {this.summary, this.recommendation});
}

final class ApproveReportEvent extends DashboardEvent {
  final String id;

  ApproveReportEvent(this.id);
}

final class DenyReportEvent extends DashboardEvent {
  final String id;
  final bool patientShouldSchedule;

  DenyReportEvent(this.id, this.patientShouldSchedule);
}