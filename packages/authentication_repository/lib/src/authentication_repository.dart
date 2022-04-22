import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';

class AuthenticationRepository {
  AuthenticationRepository({
    FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
    GoogleHelper? googleHelper,
  }) {
    _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;
    _googleSignIn = googleSignIn ?? GoogleSignIn();
    _googleHelper = googleHelper ?? GoogleHelper();
  }

  late FirebaseAuth _firebaseAuth;
  late GoogleSignIn _googleSignIn;
  late GoogleHelper _googleHelper;

  Future<User?> get getUser => Future<User?>.value(_firebaseAuth.currentUser);

  Stream<User?> get user => _firebaseAuth.authStateChanges();

  Future<bool> get appleSignInAvailable => TheAppleSignIn.isAvailable();

  FirebaseAuth get firebaseAuth => _firebaseAuth;

  // Signin with google
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      if (googleSignInAccount == null) {
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleSignInAccount.authentication;

      final OAuthCredential credential =
          _googleHelper.getGoogleOAuthCredential(googleAuth);

      final UserCredential result =
          await _firebaseAuth.signInWithCredential(credential);
      final User? user = result.user;

      return user;
    } catch (e) {
      return null;
    }
  }

  Future<User?> signInWithApple() async {
    try {
      final AuthorizationResult appleResult =
          await TheAppleSignIn.performRequests([
        const AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
      ]);

      if (appleResult.error != null) {
        return null;
      }

      final AuthCredential credential = OAuthProvider('apple.com').credential(
        accessToken: String.fromCharCodes(
          appleResult.credential!.authorizationCode ?? [],
        ),
        idToken: String.fromCharCodes(
          appleResult.credential!.identityToken ?? [],
        ),
      );

      final UserCredential result =
          await _firebaseAuth.signInWithCredential(credential);
      final User user = result.user!;

      return user;
    } catch (e) {
      return null;
    }
  }

  Future<void> verifyNumber(
    String number,
    void Function(String) verifyCallback,
  ) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: number,
        codeSent: (String verificationId, int? resendToken) async {
          verifyCallback(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {},
        verificationFailed: (FirebaseAuthException error) {
          throw error;
        },
      );
    } catch (exception) {
      throw exception;
    }
  }

  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }
}

class GoogleHelper {
  OAuthCredential getGoogleOAuthCredential(
    GoogleSignInAuthentication googleAuth,
  ) {
    return GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );
  }
}
