import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:onesignal_repository/onesignal_repository.dart';
import 'package:pickup/screens/profile/cubit/profile_cubit.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

class MockOneSignalRepository extends Mock implements OneSignalRepository {}

void main() {
  final AuthenticationRepository authenticationRepository =
      MockAuthenticationRepository();

  final OneSignalRepository oneSignalRepository = MockOneSignalRepository();
  group(
    'ProfileCubit',
    () {
      blocTest(
        '.logoutUser',
        setUp: () {
          when(() => authenticationRepository.signOut())
              .thenAnswer((_) async {});

          when(() => oneSignalRepository.logout()).thenAnswer((_) async {});
        },
        build: () => ProfileCubit(
          authenticationRepository: authenticationRepository,
          oneSignalRepository: oneSignalRepository,
        ),
        act: (ProfileCubit cubit) => cubit.logoutUser(),
        expect: () => [
          const ProfileState(status: ProfileStatus.loading),
          const ProfileState(status: ProfileStatus.loggedOut),
        ],
        verify: (cubit) {
          verify(() => authenticationRepository.signOut()).called(1);
          verify(() => oneSignalRepository.logout()).called(1);
        },
      );
    },
  );
}
