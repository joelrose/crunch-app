import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pickup/screens/onboarding_create_account/onboarding_create_account.dart';

import '../../../helpers/helpers.dart';

void main() {
  group('OnboardingCreateAccountPage', () {
    test(
      'has route',
      () => expect(
        OnboardingCreateAccountPage.route(
          data: const CreateAccountData(
            isSocialLogin: true,
          ),
        ),
        isA<MaterialPageRoute<void>>(),
      ),
    );

    testWidgets('renders OnboardingCreateAccountView', (tester) async {
      await tester.pumpApp(
        Navigator(
          onGenerateRoute: (_) => OnboardingCreateAccountPage.route(
            data: const CreateAccountData(
              isSocialLogin: true,
            ),
          ),
        ),
      );

      expect(find.byType(OnboardingCreateAccountView), findsOneWidget);
    });
  });
}
