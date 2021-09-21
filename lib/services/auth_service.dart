import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthService {
  Future<User?> get getUser;
  Stream<User?> get user;
  Future<bool> get appleSignInAvailable;

  Future<User?> signInWithGoogle();
  Future<User?> signInWithEmail(String email, String password);
  Future<bool> verifyNumber(String number);
  Future<User?> signInWithApple();
  Future<void> resetPassword(String email);
  Future<void> signOut();
}
