import 'dart:async';

import 'package:alpaca/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';

class AuthServiceFirebase implements AuthService {
  AuthServiceFirebase(
    FirebaseAuth firebaseAuth,
    GoogleSignIn googleSignIn,
    GoogleHelper googleHelper,
  ) {
    _firebaseAuth = firebaseAuth;
    _googleSignIn = googleSignIn;
    _googleHelper = googleHelper;
  }

  late FirebaseAuth _firebaseAuth;
  late GoogleSignIn _googleSignIn;
  late GoogleHelper _googleHelper;

  @override
  Future<User?> get getUser => Future<User?>.value(_firebaseAuth.currentUser);

  @override
  Stream<User?> get user => _firebaseAuth.authStateChanges();

  @override
  Future<bool> get appleSignInAvailable => TheAppleSignIn.isAvailable();

  @override
  FirebaseAuth get firebaseAuth => _firebaseAuth;

  // Signin with google
  @override
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

  @override
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

  @override
  Future<void> verifyNumber(
    String number,
    void Function(String) verifyCallback,
  ) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: number,
        codeSent: (String verificationId, int? resendToken) async {
          verifyCallback(verificationId);
          // Create a PhoneAuthCredential with the code
          // final PhoneAuthCredential credential = PhoneAuthProvider.credential(
          //   verificationId: verificationId,
          //   smsCode: smsCode,
          // );

          // // Sign the user in (or link) with the credential
          // await _firebaseAuth.currentUser!.linkWithCredential(credential);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {},
        verificationFailed: (FirebaseAuthException error) {},
      );
    } catch (e) {}
  }

  @override
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
