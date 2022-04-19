import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:pickup/screens/onboarding/account/account.dart';
import 'package:pickup/screens/onboarding/explanation/explanation.dart';
import 'package:pickup/screens/onboarding/welcome/welcome.dart';

import '../../helpers/pump_app.dart';

void main() {
  late MockNavigator navigator;

  group('Onboarding welcome widget test', () {
    setUpAll(() async {
      navigator = MockNavigator();

      when(() => navigator.pushNamed<Object?>(any())).thenAnswer((_) async {});
    });

    testWidgets('welcome screen loaded', (tester) async {
      await tester.pumpApp(const OnboardingWelcomeScreen());

      expect(find.byType(ActionButton), findsNWidgets(2));
      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('SignIn button is present and triggers navigation after tapped',
        (WidgetTester tester) async {
      await tester.pumpApp(
        const OnboardingWelcomeScreen(),
        navigator: navigator,
      );

      final primaryButton = find.byKey(
        const Key('onboarding_welcome.primary'),
      );

      expect(primaryButton, findsOneWidget);

      await tester.tap(primaryButton);
      await tester.pumpAndSettle();

      verify(
        () => navigator.pushNamed<Object?>(
          OnboardingExplanationScreen.route,
        ),
      ).called(1);
    });

    testWidgets('SignUp button is present and triggers navigation after tapped',
        (WidgetTester tester) async {
      await tester.pumpApp(
        const OnboardingWelcomeScreen(),
        navigator: navigator,
      );

      final secondaryButton = find.byKey(
        const Key('onboarding_welcome.secondary'),
      );

      expect(secondaryButton, findsOneWidget);

      await tester.tap(secondaryButton);
      await tester.pumpAndSettle();

      verify(
        () => navigator.pushNamed<Object?>(
          OnboardingAccountScreen.route,
        ),
      ).called(1);
    });
  });
}
