import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/data.dart';

part 'event.dart';
part 'state.dart';

class SidebarBloc extends Bloc<SidebarEvent, SidebarState> {
  final ApiClient _client;

  SidebarBloc({required ApiClient client})
      : _client = client,
        super(const SidebarState()) {
    on<FetchReportsInReviewEvent>(_onFetchReportsInReview);
    on<FetchDeniedReportsEvent>(_onFetchDeniedReports);
    on<SwitchReportTabEvent>(_onSwitchReportTab);
    on<SelectReportEvent>(_onSelectReport);
    on<RemoveSelectedReport>(_onRemoveSelectedReport);
    on<UpdateSelectedReportEvent>(_onUpdateSelectedReport);
  }

  Future<void> _onFetchReportsInReview(
    FetchReportsInReviewEvent event,
    Emitter<SidebarState> emit,
  ) async {
    try {
      final result = await _client.getReportsInReview();
      return emit(state.copyWith(
          status: SidebarStatus.success,
          inReviewLabReports: result,
          selectedLabReport:
              state.selectedLabReport == null && result.isNotEmpty
                  ? result[0]
                  : state.selectedLabReport));
    } catch (_) {
      emit(state.copyWith(status: SidebarStatus.failure));
    }
  }

  Future<void> _onFetchDeniedReports(
    FetchDeniedReportsEvent event,
    Emitter<SidebarState> emit,
  ) async {
    try {
      final result = await _client.getDeniedReports();
      return emit(state.copyWith(
          status: SidebarStatus.success,
          deniedLabReports: result,
          selectedLabReport:
              state.selectedLabReport == null && result.isNotEmpty
                  ? result[0]
                  : state.selectedLabReport));
    } catch (_) {
      emit(state.copyWith(status: SidebarStatus.failure));
    }
  }

  Future<void> _onSwitchReportTab(
    SwitchReportTabEvent event,
    Emitter<SidebarState> emit,
  ) async {
    List<LabReportAndPatient> result;
    try {
      if (event.showReportsInReview) {
        result = await _client.getReportsInReview();
        return emit(state.copyWith(
          status: SidebarStatus.success,
          selectedIndex: 0,
          selectedLabReport: result.isNotEmpty ? result[0] : null,
          showReportsInReview: event.showReportsInReview,
          inReviewLabReports: result,
        ));
      } else {
        result = await _client.getDeniedReports();
        return emit(state.copyWith(
          status: SidebarStatus.success,
          selectedIndex: 0,
          selectedLabReport: result.isNotEmpty ? result[0] : null,
          showReportsInReview: event.showReportsInReview,
          deniedLabReports: result,
        ));
      }
    } catch (_) {
      emit(state.copyWith(status: SidebarStatus.failure));
    }
  }

  Future<void> _onSelectReport(
    SelectReportEvent event,
    Emitter<SidebarState> emit,
  ) async {
    return emit(state.copyWith(
        selectedIndex: event.index, selectedLabReport: event.report));
  }

  Future<void> _onRemoveSelectedReport(
      RemoveSelectedReport event,
      Emitter<SidebarState> emit,
  ) async {
    if(state.selectedLabReport == null) {
      return;
    }
    if(state.showReportsInReview) {
      final inReviewLabReports = state.inReviewLabReports.toList();
      inReviewLabReports.removeAt(state.selectedIndex);

      return emit(state.copyWith(
        selectedIndex: 0,
        selectedLabReport: inReviewLabReports.isNotEmpty ? inReviewLabReports[0] : null,
        inReviewLabReports: inReviewLabReports
      ));
    } else {
      final deniedLabReports = state.deniedLabReports.toList();
      deniedLabReports.removeAt(state.selectedIndex);

      return emit(state.copyWith(
          selectedIndex: 0,
          selectedLabReport: deniedLabReports.isNotEmpty ? deniedLabReports[0] : null,
          deniedLabReports: deniedLabReports
      ));
    }
  }

  Future<void> _onUpdateSelectedReport(
      UpdateSelectedReportEvent event,
      Emitter<SidebarState> emit,
  ) async {
    if(state.showReportsInReview) {
      final inReviewLabReports = state.inReviewLabReports.toList();
      final index = inReviewLabReports.indexOf(inReviewLabReports.singleWhere((element) => element.labReport.id == event.report.labReport.id));
      inReviewLabReports[index] = event.report;

      return emit(state.copyWith(
          selectedLabReport: event.report,
          inReviewLabReports: inReviewLabReports
      ));
    } else {
      final deniedLabReports = state.inReviewLabReports.toList();
      final index = deniedLabReports.indexOf(deniedLabReports.singleWhere((element) => element.labReport.id == event.report.labReport.id));
      deniedLabReports[index] = event.report;

      return emit(state.copyWith(
          selectedLabReport: event.report,
          deniedLabReports: deniedLabReports
      ));
    }
  }
}
