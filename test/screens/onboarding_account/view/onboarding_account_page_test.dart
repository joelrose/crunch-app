import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:pickup/screens/onboarding_account/onboarding_account.dart';

import '../../../helpers/helpers.dart';

void main() {
  group('OnboardingAccountPage', () {
    test(
      'has route',
      () => expect(
        OnboardingAccountPage.route(isSignUp: true),
        isA<MaterialPageRoute<void>>(),
      ),
    );

    // TODO: fix widget overflow
   /* testWidgets('renders OnboardingAccountView', (tester) async {
      await tester.pumpApp(
        Navigator(
          onGenerateRoute: (_) => OnboardingAccountPage.route(isSignUp: true),
        ),
      );
      expect(find.byType(OnboardingAccountView), findsOneWidget);
    });*/
  });

  group('OnboardingWelcomeView', () {
    late MockNavigator navigator;

    setUp(() async {
      navigator = MockNavigator();
    });
  });
}
