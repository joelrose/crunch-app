import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockAuthCredential extends Mock implements AuthCredential {}

void main() {
  final _fakeUser = MockUser(
    uid: 'someuid',
    email: 'bob@somedomain.com',
    displayName: 'Bob',
  );

  group('Returns no user if not signed in', () {
    test('Returns no user if not signed in', () async {
      final auth = MockFirebaseAuth();

      final user = auth.currentUser;

      expect(user, isNull);
    });
  });

  group('Returns a user after sign in', () {
    test('with credentials', () async {
      final auth = MockFirebaseAuth();
      final credential = MockAuthCredential();

      final result = await auth.signInWithCredential(credential);
      final user = result.user!;

      expect(user.uid, isNotEmpty);
      expect(user.isAnonymous, isFalse);
    });

    test('Returns a user if already signed in', () async {
      final auth = MockFirebaseAuth(
        signedIn: true,
        mockUser: _fakeUser,
      );

      final user = auth.currentUser!;

      expect(user.uid, _fakeUser.uid);
      expect(user.email, _fakeUser.email);
      expect(user.displayName, _fakeUser.displayName);
    });

    test('Returns null after sign out', () async {
      final auth = MockFirebaseAuth(signedIn: true);
      final user = auth.currentUser;

      await auth.signOut();

      expect(auth.currentUser, isNull);
      expect(auth.authStateChanges(), emitsInOrder([user, null]));
    });
  });
}
