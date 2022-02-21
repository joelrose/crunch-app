import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pickup/screens/onboarding/create_account/steps/set_password.dart';

void main() {
  // Widget tests
  testWidgets('''password and repeat password are empty at initial load''',
      (tester) async {
    // ASSEMBLE
    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(),
        child: MaterialApp(
          home: Scaffold(
            body: StepSetPassword(
              whichStepInCreateAccount: () {},
            ),
          ),
        ),
      ),
      const Duration(seconds: 1),
    );

    expect(find.text(''), findsNWidgets(2));
  });

  testWidgets('''only type in password with too less digits''', (tester) async {
    // ASSEMBLE
    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(),
        child: MaterialApp(
          home: Scaffold(
            body: StepSetPassword(
              whichStepInCreateAccount: () {},
            ),
          ),
        ),
      ),
      const Duration(seconds: 1),
    );

    final password = find.byKey(const Key('onboarding_password_textfield'));
    final continueButton = find.byType(ActionButton);
    final passwordErrorMessage = find.text('Please enter a valid password');
    final repeatPasswordErrorMessage = find.text("Passwords don't match");

    // ACT
    await tester.enterText(password, 'abc');
    await tester.tap(continueButton);
    await tester.pump();
    // ASSERT
    expect(passwordErrorMessage, findsOneWidget);
    expect(repeatPasswordErrorMessage, findsOneWidget);
  });

  testWidgets('''only type in password with enough digits''', (tester) async {
    // ASSEMBLE
    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(),
        child: MaterialApp(
          home: Scaffold(
            body: StepSetPassword(
              whichStepInCreateAccount: () {},
            ),
          ),
        ),
      ),
      const Duration(seconds: 1),
    );

    final password = find.byKey(const Key('onboarding_password_textfield'));
    final continueButton = find.byType(ActionButton);
    final repeatPasswordErrorMessage = find.text("Passwords don't match");

    //ACT
    await tester.enterText(password, 'abc34f');
    await tester.tap(continueButton);
    await tester.pump();

    // ASSERT
    expect(repeatPasswordErrorMessage, findsOneWidget);
  });

  testWidgets('''only type in repeated password''', (tester) async {
    // ASSEMBLE
    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(),
        child: MaterialApp(
          home: Scaffold(
            body: StepSetPassword(
              whichStepInCreateAccount: () {},
            ),
          ),
        ),
      ),
      const Duration(seconds: 1),
    );

    final repeatPassword =
        find.byKey(const Key('onboarding_repeat_password_textfield'));
    final continueButton = find.byType(ActionButton);
    final passwordErrorMessage = find.text('Please enter a valid password');
    final repeatPasswordErrorMessage = find.text("Passwords don't match");

    //ACT
    await tester.enterText(repeatPassword, 'abcdefg');
    await tester.tap(continueButton);
    await tester.pump();

    // ASSERT
    expect(passwordErrorMessage, findsOneWidget);
    expect(repeatPasswordErrorMessage, findsOneWidget);
  });

  testWidgets('''repeat password doesn't match password''', (tester) async {
    // ASSEMBLE
    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(),
        child: MaterialApp(
          home: Scaffold(
            body: StepSetPassword(
              whichStepInCreateAccount: () {},
            ),
          ),
        ),
      ),
      const Duration(seconds: 1),
    );

    final password = find.byKey(const Key('onboarding_password_textfield'));
    final repeatPassword =
        find.byKey(const Key('onboarding_repeat_password_textfield'));
    final continueButton = find.byType(ActionButton);
    final repeatPasswordErrorMessage = find.text("Passwords don't match");

    //ACT
    await tester.enterText(password, 'abc123');
    await tester.enterText(repeatPassword, 'abcd4124');
    await tester.tap(continueButton);
    await tester.pump();

    // ASSERT
    expect(repeatPasswordErrorMessage, findsOneWidget);
  });
  testWidgets(
      '''password and repeat password are matching with too less digits''',
      (tester) async {
    // ASSEMBLE
    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(),
        child: MaterialApp(
          home: Scaffold(
            body: StepSetPassword(
              whichStepInCreateAccount: () {},
            ),
          ),
        ),
      ),
      const Duration(seconds: 1),
    );

    final password = find.byKey(const Key('onboarding_password_textfield'));
    final repeatPassword =
        find.byKey(const Key('onboarding_repeat_password_textfield'));
    final continueButton = find.byType(ActionButton);
    final passwordErrorMessage = find.text('Please enter a valid password');

    //ACT
    await tester.enterText(password, 'abc1');
    await tester.enterText(repeatPassword, 'abc1');
    await tester.tap(continueButton);
    await tester.pump();

    // ASSERT
    expect(passwordErrorMessage, findsOneWidget);
  });

  testWidgets(
      '''password and repeat password are matching with enough digits''',
      (tester) async {
    // ASSEMBLE
    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(),
        child: MaterialApp(
          home: Scaffold(
            body: StepSetPassword(
              whichStepInCreateAccount: () {},
            ),
          ),
        ),
      ),
      const Duration(seconds: 1),
    );

    final password = find.byKey(const Key('onboarding_password_textfield'));
    final repeatPassword =
        find.byKey(const Key('onboarding_repeat_password_textfield'));
    final continueButton = find.byType(ActionButton);
    final repeatPasswordErrorMessage = find.text("Passwords don't match");
    final passwordErrorMessage = find.text('Please enter a valid password');

    //ACT
    await tester.enterText(password, 'abc123');
    await tester.enterText(repeatPassword, 'abc123');
    await tester.tap(continueButton);
    await tester.pump();

    // ASSERT
    expect(passwordErrorMessage, findsNothing);
    expect(repeatPasswordErrorMessage, findsNothing);
  });
}
