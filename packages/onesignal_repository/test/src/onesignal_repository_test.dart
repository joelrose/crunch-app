import 'package:authentication_repository/authentication_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:onesignal_repository/onesignal_repository.dart';
import 'package:test/test.dart';

class MockOneSignal extends Mock implements OneSignal {}

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

class MockUser extends Mock implements User {}

void main() {
  group('OneSignalRepository', () {
    late MockAuthenticationRepository mockAuthenticationRepository;
    late MockOneSignal mockOneSignal;

    const email = 'crunchœcrunch.app';
    const uid = '123456';
    const displayName = 'crunch';
    const appId = '654321';

    setUpAll(() async {
      mockOneSignal = MockOneSignal();

      mockAuthenticationRepository = MockAuthenticationRepository();

      OneSignal.shared = mockOneSignal;

      // MockUser
      final mockUser = MockUser();

      when(() => mockUser.email).thenReturn(email);

      when(() => mockUser.uid).thenReturn(uid);

      when(() => mockUser.displayName).thenReturn(displayName);

      when(() => mockAuthenticationRepository.getUser)
          .thenAnswer((_) => Future<MockUser>.value(mockUser));

      /// MockOneSignal
      when(() => mockOneSignal.setExternalUserId(any())).thenAnswer(
        (_) => Future.value({}),
      );

      when(() => mockOneSignal.setEmail(email: any(named: 'email')))
          .thenAnswer((_) => Future.value());

      when(() => mockOneSignal.setAppId(any()))
          .thenAnswer((_) => Future.value());

      when(
        () => mockOneSignal.promptUserForPushNotificationPermission(),
      ).thenAnswer(
        (_) => Future.value(true),
      );
    });

    test('initOneSignal works as expected', () async {
      final oneSignalRepo = OneSignalRepository(
        authenticationRepository: mockAuthenticationRepository,
      );

      await oneSignalRepo.initOneSignal(appId);

      verify(() => mockOneSignal.setAppId(appId)).called(1);

      verify(
        () => mockOneSignal.setEmail(email: email),
      ).called(1);

      verify(() => mockOneSignal.setExternalUserId(uid)).called(1);

      verify(() => mockOneSignal.promptUserForPushNotificationPermission())
          .called(1);

      verify(() => mockAuthenticationRepository.getUser).called(1);
    });
  });
}
