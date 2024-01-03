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
        selectedLabReport: state.selectedLabReport == null && result.isNotEmpty ? result[0] : state.selectedLabReport));
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
        selectedLabReport: state.selectedLabReport == null && result.isNotEmpty ? result[0] : state.selectedLabReport
      ));
    } catch (_) {
      emit(state.copyWith(status: SidebarStatus.failure));
    }
  }

  Future<void> _onSwitchReportTab(
    SwitchReportTabEvent event,
    Emitter<SidebarState> emit,
  ) async {
    SidebarStatus status = SidebarStatus.initial;
    if(event.showReportsInReview && state.inReviewLabReports.isNotEmpty
      || !event.showReportsInReview && state.deniedLabReports.isNotEmpty
    ) {
      status = SidebarStatus.success;
    }
    return emit(state.copyWith(
        status: status,
        selectedIndex: 0,
        selectedLabReport: null,
        showReportsInReview: event.showReportsInReview));
  }

  Future<void> _onSelectReport(
    SelectReportEvent event,
    Emitter<SidebarState> emit,
  ) async {
    return emit(state.copyWith(
        selectedIndex: event.index,
        selectedLabReport: event.report));
  }
}
