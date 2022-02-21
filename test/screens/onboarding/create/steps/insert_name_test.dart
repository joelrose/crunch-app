// import 'package:alpaca/alpaca.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:pickup/screens/onboarding/create_account/steps/insert_name.dart';

// void main() {
//   testWidgets('type in first name without lastname', (tester) async {
//     // Assamble
//     await tester.pumpWidget(
//       MediaQuery(
//         data: const MediaQueryData(),
//         child: MaterialApp(
//           home: Scaffold(
//             body: StepInsertName(
//               whichStepInCreateAccount: () {},
//             ),
//           ),
//         ),
//       ),
//       const Duration(seconds: 1),
//     );

//     final firstname = find.byKey(const Key('onboarding_firstname_textfield'));
//     final continueButton = find.byType(ActionButton);
//     final nameErrorMessage = find.text('Please enter a valid name');

//     // Act
//     await tester.enterText(firstname, 'Paul');
//     await tester.tap(continueButton);
//     await tester.pump();

//     // Assert
//     expect(nameErrorMessage, findsOneWidget);
//   });

//   testWidgets('type in lastname without firstname', (tester) async {
//     // Assamble
//     await tester.pumpWidget(
//       MediaQuery(
//         data: const MediaQueryData(),
//         child: MaterialApp(
//           home: Scaffold(
//             body: StepInsertName(
//               whichStepInCreateAccount: () {},
//             ),
//           ),
//         ),
//       ),
//       const Duration(seconds: 1),
//     );

//     final lastname = find.byKey(const Key('onboarding_lastname_textfield'));
//     final continueButton = find.byType(ActionButton);
//     final nameErrorMessage = find.text('Please enter a valid name');

//     // Act
//     await tester.enterText(lastname, 'Thomas');
//     await tester.tap(continueButton);
//     await tester.pump();

//     // Assert
//     expect(nameErrorMessage, findsOneWidget);
//   });

//   testWidgets('leave lastname and firstname empty', (tester) async {
//     // Assamble
//     await tester.pumpWidget(
//       MediaQuery(
//         data: const MediaQueryData(),
//         child: MaterialApp(
//           home: Scaffold(
//             body: StepInsertName(
//               whichStepInCreateAccount: () {},
//             ),
//           ),
//         ),
//       ),
//       const Duration(seconds: 1),
//     );

//     final continueButton = find.byType(ActionButton);
//     final nameErrorMessage = find.text('Please enter a valid name');

//     // Act
//     await tester.tap(continueButton);
//     await tester.pump();

//     // Assert
//     expect(nameErrorMessage, findsNWidgets(2));
//   });

//   testWidgets('type in first and lastname with one digit', (tester) async {
//     // Assamble
//     await tester.pumpWidget(
//       MediaQuery(
//         data: const MediaQueryData(),
//         child: MaterialApp(
//           home: Scaffold(
//             body: StepInsertName(
//               whichStepInCreateAccount: () {},
//             ),
//           ),
//         ),
//       ),
//       const Duration(seconds: 1),
//     );

//     final firstname = find.byKey(const Key('onboarding_firstname_textfield'));
//     final lastname = find.byKey(const Key('onboarding_lastname_textfield'));
//     final continueButton = find.byType(ActionButton);
//     final nameErrorMessage = find.text('Please enter a valid name');

//     // Act
//     await tester.enterText(firstname, 'A');
//     await tester.enterText(lastname, 'B');
//     await tester.tap(continueButton);
//     await tester.pump();

//     // Assert
//     expect(nameErrorMessage, findsNWidgets(2));
//   });
// }
