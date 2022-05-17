import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:pickup/screens/onboarding_account/onboarding_account.dart';

import '../../../helpers/helpers.dart';

void main() {
  group('OnboardingAccountPage', () {
    /*test(
      'has route',
      () => expect(
        OnboardingAccountPage.route(isSignUp: true),
        isA<MaterialPageRoute<void>>(),
      ),
    );*/

    testWidgets('renders OnboardingAccountView', (tester) async {
      /*final AuthenticationRepository authenticationRepository =
          MockAuthenticationRepository();

      when(() => authenticationRepository.appleSignInAvailable)
          .thenAnswer((_) => Future<bool>.value(true));

      await tester.binding.setSurfaceSize(const Size(750, 1334));

      await tester.pumpApp(
        Navigator(
          onGenerateRoute: (_) => OnboardingAccountPage.route(isSignUp: false),
        ),
        authenticationRepository: authenticationRepository,
      );

      await tester.pumpAndSettle();

      expect(find.byType(OnboardingAccountView), findsOneWidget);*/
    });
  });
}
