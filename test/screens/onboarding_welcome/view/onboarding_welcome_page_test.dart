import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:pickup/screens/onboarding/account/account.dart';
import 'package:pickup/screens/onboarding/explanation/explanation.dart';
import 'package:pickup/screens/onboarding_welcome/onboarding_welcome.dart';

import '../../../helpers/helpers.dart';

void main() {
  group('OnboardingWelcomePage', () {
    test(
      'has route',
      () => expect(
        OnboardingWelcomePage.route(),
        isA<MaterialPageRoute<void>>(),
      ),
    );

    testWidgets('renders OnboardingWelcomeView', (tester) async {
      await tester.pumpApp(
        Navigator(
          onGenerateRoute: (_) => OnboardingWelcomePage.route(),
        ),
      );
      expect(find.byType(OnboardingWelcomeView), findsOneWidget);
    });
  });

  group('OnboardingWelcomeView', () {
    late MockNavigator navigator;

    setUp(() async {
      navigator = MockNavigator();
    });

    testWidgets(
        'navigates to OnboardingExplanationScreen when SignIn button is pressed',
        (WidgetTester tester) async {
      when(() => navigator.pushNamed<Object?>(any())).thenAnswer((_) async {});

      await tester.pumpApp(
        const OnboardingWelcomeView(),
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

    testWidgets(
        'navigates to OnboardingAccountPage when SignUp button is pressed',
        (WidgetTester tester) async {
      when(() => navigator.pushNamed<Object?>(any(), arguments: false))
          .thenAnswer(
        (_) async {},
      );

      await tester.pumpApp(
        const OnboardingWelcomeView(),
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
          arguments: false,
        ),
      ).called(1);
    });
  });
}
