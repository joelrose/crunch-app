part of 'app_outdated_bloc.dart';

enum AppOutdatedStatus { initial, awaiting, outdated, failure }

class AppOutdatedState extends Equatable {
  const AppOutdatedState({
    this.status = AppOutdatedStatus.initial,
  });

  final AppOutdatedStatus status;

  @override
  List<Object> get props => [status];
}
