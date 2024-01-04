import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/data.dart';

part 'event.dart';
part 'state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final ApiClient _client;

  DashboardBloc({
    required ApiClient client
  }) : _client = client,
      super(const DashboardState()) {
    on<EditReportEvent>(
      _onEditReport
    );
    on<ApproveReportEvent>(
      _onApproveReport
    );
    on<DenyReportEvent> (
      _onDenyReport
    );
  }

  Future<void> _onEditReport(
    EditReportEvent event,
    Emitter<DashboardState> emit,
  ) async {
    try {
      print("Report edited");
      await _client.editReport(event.id, event.summary, event.recommendation);
      print("Report edited");

      return emit(
        state.copyWith(
          status: DashboardStatus.success,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: DashboardStatus.failure));
    }
  }

  Future<void> _onApproveReport(
      ApproveReportEvent event,
      Emitter<DashboardState> emit,
      ) async {
    try {
      await _client.approve(event.id);
      return emit(
        state.copyWith(
          status: DashboardStatus.success,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: DashboardStatus.failure));
    }
  }

  Future<void> _onDenyReport(
      DenyReportEvent event,
      Emitter<DashboardState> emit,
      ) async {
    try {
      await _client.deny(event.id, event.patientShouldSchedule);

      return emit(
        state.copyWith(
          status: DashboardStatus.success,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: DashboardStatus.failure));
    }
  }
}