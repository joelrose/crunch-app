import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthService {
  Future<User?> get getUser;
  Stream<User?> get user;
  Future<bool> get appleSignInAvailable;
  FirebaseAuth get firebaseAuth;

  Future<User?> signInWithGoogle();
  Future<void> verifyNumber(
    String number,
    void Function(String) verifyCallback,
  );
  Future<User?> signInWithApple();
  Future<void> signOut();
}
