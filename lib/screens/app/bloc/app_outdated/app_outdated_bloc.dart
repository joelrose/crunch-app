import 'package:app_outdated_repository/app_outdated_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_outdated_event.dart';
part 'app_outdated_state.dart';

class AppOutdatedBloc extends Bloc<AppOutdatedEvent, AppOutdatedState> {
  AppOutdatedBloc({required AppOutdatedRepository appOutdatedRepository})
      : _appOutdatedRepository = appOutdatedRepository,
        super(const AppOutdatedState()) {
    on<AppOutdatedSubscriptionRequested>(_onSubscriptionRequested);
  }

  final AppOutdatedRepository _appOutdatedRepository;

  Future<void> _onSubscriptionRequested(
    AppOutdatedSubscriptionRequested event,
    Emitter<AppOutdatedState> emit,
  ) async {
    await emit.forEach<bool>(
      _appOutdatedRepository.appOutdatedStream(),
      onData: (outdated) => outdated
          ? const AppOutdatedState(
              status: AppOutdatedStatus.outdated,
            )
          : state,
      onError: (_, __) => const AppOutdatedState(
        status: AppOutdatedStatus.failure,
      ),
    );
  }
}
