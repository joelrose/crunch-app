import 'package:authentication_repository/authentication_repository.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class OneSignalRepository {
  OneSignalRepository({
    required AuthenticationRepository authenticationRepository,
  }) {
    _authenticationRepository = authenticationRepository;
  }

  late AuthenticationRepository _authenticationRepository;

  Future<void> initOneSignal(String appId) async {
    final accepted =
        await OneSignal.shared.promptUserForPushNotificationPermission();

    if (!accepted) return;

    OneSignal.shared.setAppId(appId);

    final user = await _authenticationRepository.getUser;

    if (user != null) {
      OneSignal.shared.setExternalUserId(user.uid);

      if (user.email != null) {
        OneSignal.shared.setEmail(email: user.email!);
      }
    }
  }

  Future<void> logout() async {
    await OneSignal.shared.disablePush(true);
  }
}
