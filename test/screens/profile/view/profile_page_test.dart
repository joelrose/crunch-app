import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:pickup/screens/profile/view/profile_page.dart';
import 'package:pickup/screens/profile/widgets/profile_tile.dart';

import '../../../helpers/helpers.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  group(
    'Profile page',
    () {
      testWidgets('page loads and shows content', (tester) async {
        await tester.pumpApp(ProfilePage());

        expect(find.byType(ProfileTile), findsNWidgets(5));
      });

      testWidgets('logout button works as expected', (tester) async {
        final MockNavigator navigator = MockNavigator();
        final AuthenticationRepository authenticationRepository =
            MockAuthenticationRepository();

        when(() => authenticationRepository.signOut()).thenAnswer((_) async {});

        when(() => navigator.pushAndRemoveUntil<void>(any(), any()))
            .thenAnswer((_) async {});

        await tester.pumpApp(
          ProfilePage(),
          navigator: navigator,
          authenticationRepository: authenticationRepository,
        );

        final logoutButton = find.byKey(
          const Key('logout_button'),
        );

        expect(logoutButton, findsOneWidget);

        await tester.tap(logoutButton);
        await tester.pumpAndSettle();

        verify(
          () => authenticationRepository.signOut(),
        ).called(1);

        verify(
          () => navigator.pushAndRemoveUntil<void>(
            any(that: isRoute<void>()),
            any(),
          ),
        ).called(1);
      });
    },
  );
}
