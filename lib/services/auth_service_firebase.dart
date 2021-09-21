import 'dart:async';

import 'package:alpaca/services/auth_service.dart';
import 'package:alpaca/services/exception.dart';
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
      // updateUserData(user, displayName);

      return user;
    } catch (e) {
      return null;
    }
  }

  // Signin with email & password
  @override
  Future<User> signInWithEmail(String email, String password) async {
    try {
      final UserCredential result =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = result.user;

      if (user != null && user.emailVerified) {
        final String displayName = user.displayName ?? '';
        // updateUserData(user, displayName);
        return user;
      } else {
        throw EmailNotVerifiedException(
          'Deine E-Mail ist noch nicht bestätigt. Bitte prüfe dein Postfach und bestätige deine E-Mail-Adresse.',
        );
      }
    } on FirebaseAuthException catch (fae) {
      switch (fae.code) {
        case 'wrong-password':
          throw PasswordWrongException('E-Mail oder Passwort falsch.');
        case 'user-disabled':
          throw UserDisabledException(
            'Dein Account ist deaktiviert. Bitte überprüfe deine E-Mails und aktiviere deninen Account.',
          );
        case 'invalid-email':
          throw InvalidEmailException(
            'Ungültige E-Mail eingegeben.',
          );
        case 'user-not-found':
          throw NoAccountException(
            'Dieser Account existiert nicht.',
          );
        case 'too-many-requests':
          throw AuthRefusedException(
            'Dieses Device wurde blockiert, da zu viele ungewöhnliche Requests gesendet wurden. Versuche es später noch einmal.',
          );
        default:
          throw UnknownException(
            'Ups... da ging wohl etwas schief. Wir arbeiten bereits daran.',
          );
      }
    } on Exception {
      rethrow;
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

      final String displayName = user.displayName ?? '';
      // updateUserData(user, displayName);

      return user;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> verifyNumber(String number) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: number,
        codeSent: (String verificationId, int? resendToken) async {
          // Update the UI - wait for the user to enter the SMS code
          String smsCode = '999999';

          // Create a PhoneAuthCredential with the code
          final PhoneAuthCredential credential = PhoneAuthProvider.credential(
              verificationId: verificationId, smsCode: smsCode);

          // Sign the user in (or link) with the credential
          await _firebaseAuth.currentUser!.linkWithCredential(credential);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {},
        verificationFailed: (FirebaseAuthException error) {},
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  // Register with email & password
  @override
  Future<User?> registerUserWithEmailAndPassword(
    String displayName,
    String email,
    String password,
  ) async {
    // try {
    //   final UserCredential result = await _firebaseAuth
    //       .createUserWithEmailAndPassword(email: email, password: password);
    //   final User? user = result.user;

    //   await user.sendEmailVerification();

    //   updateUserData(user, displayName);
    //   return user;
    // } catch (e) {
    //   return null;
    // }
  }

  // Reset password for account
  @override
  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
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
