import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:pickup/screens/onboarding/account/account.dart';
import 'package:pickup/screens/onboarding/explanation/explanation.dart';
import 'package:pickup/screens/onboarding/welcome/welcome.dart';
import 'package:pickup/shared/routes.dart' as routes;

import '../../test_helper.dart';
import '../../test_helper.mocks.dart';

final mockObserver = MockNavigatorObserver();

Widget createWelcomeScreen() => MaterialApp(
      home: const OnboardingWelcomeScreen(),
      navigatorObservers: [mockObserver],
      onGenerateRoute: routes.Router.generateRoute,
      theme: getThemeData(),
    );

void main() {
  setUp(() async {
    final GetIt locator = GetIt.instance;
    locator.allowReassignment = true;

    TestHelper.registerMockAuthService(locator);
  });
  group('Onboarding welcome widget test', () {
    testWidgets('welcome screen loaded', (tester) async {
      await tester.pumpWidget(createWelcomeScreen());

      expect(find.byType(ActionButton), findsNWidgets(2));
      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('SignIn button is present and triggers navigation after tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWelcomeScreen());

      final primaryButton = find.byKey(
        const Key('onboarding_welcome.primary'),
      );

      expect(primaryButton, findsOneWidget);
      await tester.tap(primaryButton);
      await tester.pumpAndSettle();

      verify(mockObserver.didPush(any, any));

      expect(find.byType(OnboardingExplanationScreen), findsOneWidget);
    });

    testWidgets('SignUp button is present and triggers navigation after tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWelcomeScreen());

      final secondaryButton = find.byKey(
        const Key('onboarding_welcome.secondary'),
      );

      expect(secondaryButton, findsOneWidget);
      await tester.tap(secondaryButton);
      await tester.pumpAndSettle();

      verify(mockObserver.didPush(any, any));

      expect(find.byType(OnboardingAccountScreen), findsOneWidget);
    });
  });
}
