part of 'bloc.dart';

sealed class SidebarEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class FetchReportsInReviewEvent extends SidebarEvent {}

final class FetchDeniedReportsEvent extends SidebarEvent {}

final class SwitchReportTabEvent extends SidebarEvent {
  final bool showReportsInReview;

  SwitchReportTabEvent(this.showReportsInReview);
}

final class SelectReportEvent extends SidebarEvent {
  final int index;
  final LabReportAndPatient report;

  SelectReportEvent(this.index, this.report);
}