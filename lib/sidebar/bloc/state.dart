part of 'bloc.dart';

enum SidebarStatus { initial, success, failure }

final class SidebarState extends Equatable {
  const SidebarState({
    this.status = SidebarStatus.initial,
    this.inReviewLabReports = const <LabReportAndPatient>[],
    this.deniedLabReports = const <LabReportAndPatient>[],
    this.showReportsInReview = true,
    this.selectedIndex = 0,
    this.selectedLabReport
  });

  final SidebarStatus status;
  final List<LabReportAndPatient> inReviewLabReports;
  final List<LabReportAndPatient> deniedLabReports;
  final bool showReportsInReview;
  final int selectedIndex;
  final LabReportAndPatient? selectedLabReport;

  SidebarState copyWith({
    SidebarStatus? status,
    List<LabReportAndPatient>? inReviewLabReports,
    List<LabReportAndPatient>? deniedLabReports,
    bool? showReportsInReview,
    int? selectedIndex,
    LabReportAndPatient? selectedLabReport,
    bool setSelectedLabReportNull = false
  }) {
    return SidebarState(
      status: status ?? this.status,
      inReviewLabReports: inReviewLabReports ?? this.inReviewLabReports,
      deniedLabReports: deniedLabReports ?? this.deniedLabReports,
      showReportsInReview: showReportsInReview ?? this.showReportsInReview,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      selectedLabReport: setSelectedLabReportNull ? null : (selectedLabReport ?? this.selectedLabReport),
    );
  }

  @override
  String toString() {
    return '''ChatState {
    status: $status,
    inReviewLabReports: $inReviewLabReports,
    deniedLabReports: $deniedLabReports,
    showReportsInReview: $showReportsInReview,
    selectedIndex: $selectedIndex
    selectedLabReport: ${selectedLabReport?.labReport.id}
    }''';
  }

  @override
  List<Object?> get props => [status, inReviewLabReports, deniedLabReports, showReportsInReview, selectedIndex, selectedLabReport];
}
