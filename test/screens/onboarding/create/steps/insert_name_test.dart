import 'package:alpaca/screens/onboarding/create/steps/insert_name.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  testWidgets('insert name ...', (tester) async {
    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(),
        child: MaterialApp(
          home: Scaffold(
            body: StepInsertName(
              whichStepInCreateAccount: () {},
            ),
          ),
        ),
      ),
    );
  });
}
