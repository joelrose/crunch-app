import 'package:authentication_repository/authentication_repository.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class OneSignalRepository {
  OneSignalRepository({required this.authenticationRepository}) {}

  final AuthenticationRepository authenticationRepository;

  Future<void> initOneSignal(String appId) async {
    OneSignal.shared.setAppId(appId);

    OneSignal.shared
        .promptUserForPushNotificationPermission()
        .then((accepted) async {
      final user = await authenticationRepository.getUser;

      if (user != null) {
        OneSignal.shared.setExternalUserId(user.uid);

        if (user.email != null) {
          OneSignal.shared.setEmail(email: user.email!);
        }
      }
    });
  }
}
