import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:pickup/screens/onboarding_explanation/onboarding_explanation.dart';
import 'package:pickup/screens/onboarding_explanation/widgets/widgets.dart';

import '../../../helpers/helpers.dart';

void main() {
  group('OnboardingExplanationPage', () {
    test(
      'has route',
      () => expect(
        OnboardingExplanationPage.route(),
        isA<MaterialPageRoute<void>>(),
      ),
    );

    testWidgets('renders OnboardingExplanationView', (tester) async {
      await tester.pumpApp(
        Navigator(
          onGenerateRoute: (_) => OnboardingExplanationPage.route(),
        ),
      );
      expect(find.byType(OnboardingExplanationView), findsOneWidget);
    });
    testWidgets('renders Slider', (tester) async {
      await tester.pumpApp(
        Navigator(
          onGenerateRoute: (_) => OnboardingExplanationPage.route(),
        ),
      );

      expect(find.byType(SlideWidget), findsOneWidget);
      expect(find.byType(DotsIndicator), findsOneWidget);
    });
  });

  group('OnboardingWelcomeView', () {
    late MockNavigator navigator;

    setUp(() async {
      navigator = MockNavigator();
    });

    testWidgets(
        'navigates to OnboardingAccountScreen when next button is pressed',
        (WidgetTester tester) async {
      when(() => navigator.push<void>(any())).thenAnswer((_) async {});

      await tester.pumpApp(
        const OnboardingExplanationView(),
        navigator: navigator,
      );

      final nextButton = find.byKey(
        const Key('onboarding_explanation.next'),
      );

      expect(nextButton, findsOneWidget);

      await tester.tap(nextButton);
      await tester.pumpAndSettle();

      verify(
        () => navigator.push<void>(
          any(that: isRoute<void>()),
        ),
      ).called(1);
    });

    testWidgets(
        'navigates to OnboardingAccountPage when SignUp button is pressed',
        (WidgetTester tester) async {
      when(() => navigator.pop()).thenAnswer(
        (_) async {},
      );

      await tester.pumpApp(
        const OnboardingExplanationView(),
        navigator: navigator,
      );

      final backButton = find.byKey(
        const Key('onboarding_explanation.back'),
      );

      expect(backButton, findsOneWidget);

      await tester.tap(backButton);
      await tester.pumpAndSettle();

      verify(
        () => navigator.pop(),
      ).called(1);
    });
  });
}
