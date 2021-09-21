
import 'package:alpaca/services/auth_service.dart';
import 'package:alpaca/services/auth_service_firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

GetIt locator = GetIt.instance;

Future<void> setupServiceLocator() async {
  await Firebase.initializeApp();

  if (!locator.isRegistered<AuthService>()) {
    locator.registerLazySingleton<AuthService>(
      () => AuthServiceFirebase(
        FirebaseAuth.instance,
        GoogleSignIn(),
        GoogleHelper(),
      ),
    );
  }
}
