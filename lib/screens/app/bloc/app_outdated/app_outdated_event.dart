part of 'app_outdated_bloc.dart';

abstract class AppOutdatedEvent extends Equatable {
  const AppOutdatedEvent();

  @override
  List<Object> get props => [];
}

class AppOutdatedSubscriptionRequested extends AppOutdatedEvent {
  const AppOutdatedSubscriptionRequested();
}

abstract class AppOutdatedItem extends AppOutdatedEvent {
  const AppOutdatedItem({required this.outdated});

  final bool outdated;

  @override
  List<Object> get props => [outdated];
}
