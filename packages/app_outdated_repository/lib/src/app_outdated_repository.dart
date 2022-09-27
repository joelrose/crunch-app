import 'package:rxdart/rxdart.dart';

class AppOutdatedRepository {
  AppOutdatedRepository() {}

  final _outdatedStreamController =
      BehaviorSubject<bool>.seeded(false);

  Stream<bool> appOutdatedStream() =>
      _outdatedStreamController.asBroadcastStream();

  void pushOutdated() {
    _outdatedStreamController.add(true);
  }
}
