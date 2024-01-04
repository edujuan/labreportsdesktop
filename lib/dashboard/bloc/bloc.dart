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
    /*on<ApproveReportEvent>(

    );
    on<DenyReportEvent> (

    );*/
  }

  Future<void> _onEditReport(
    EditReportEvent event,
    Emitter<DashboardState> emit,
  ) async {
    try {
      // await _client.sendMessage(event.message);
      // final result = await _client.getMessages();

      /*final messages = state.messages;

      final result = <Message>[
        ...messages,
        Message(id: 'unique-id', message: event.message, userId: 'me'),
      ];*/

      return emit(
        state.copyWith(
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: DashboardStatus.failure));
    }
  }
}