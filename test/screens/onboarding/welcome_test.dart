import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:pickup/screens/onboarding/account/account.dart';
import 'package:pickup/screens/onboarding/explanation/explanation.dart';
import 'package:pickup/screens/onboarding/welcome/welcome.dart';
import 'package:pickup/shared/routes.dart' as routes;

import '../../helpers/pump_app.dart';
import '../../test_helper.dart';

Widget createWelcomeScreen() => MaterialApp(
      home: const OnboardingWelcomeScreen(),
      onGenerateRoute: routes.Router.generateRoute,
      theme: getThemeData(),
    );

void main() {
  late MockNavigator navigator;

  group('Onboarding welcome widget test', () {
    setUpAll(() async {
      final GetIt locator = GetIt.instance;
      locator.allowReassignment = true;

      TestHelper.registerMockAuthService(locator);

      navigator = MockNavigator();

      when(() => navigator.pushNamed<Object?>(any())).thenAnswer((_) async {});
    });

    testWidgets('welcome screen loaded', (tester) async {
      await tester.pumpWidget(createWelcomeScreen());

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
