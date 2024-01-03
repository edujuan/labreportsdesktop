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

  }

}