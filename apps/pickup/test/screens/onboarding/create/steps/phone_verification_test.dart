import 'package:alpaca/screens/onboarding/create/steps/phone_verification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockAuth extends Mock implements FirebaseAuth {
  
}

void main() {
  final MockAuth mockAuth = MockAuth();
  setUp(() {});
  tearDown(() {});
}