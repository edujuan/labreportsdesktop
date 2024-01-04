part of 'bloc.dart';

enum DashboardStatus { initial, success, failure }

final class DashboardState extends Equatable {
  const DashboardState({
    this.status = DashboardStatus.success,
  });

  final DashboardStatus status;

  DashboardState copyWith({
    DashboardStatus? status,
  }) {
    return DashboardState(
      status: status ?? this.status,
    );
  }

  @override
  String toString() {
    return '''ChatState { status: $status }''';
  }

  @override
  List<Object?> get props => [status];
}
