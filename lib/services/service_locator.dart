import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pickup/screens/store/store_screen_model.dart';
import 'package:pickup/services/auth_service.dart';
import 'package:pickup/services/auth_service_firebase.dart';
import 'package:pickup/services/hermes_service.dart';
import 'package:sanity/sanity.dart';

GetIt locator = GetIt.instance;

Future<void> setupServiceLocator() async {
  if (!locator.isRegistered<AuthService>()) {
    locator.registerLazySingleton<AuthService>(
      () => AuthServiceFirebase(
        FirebaseAuth.instance,
        GoogleSignIn(),
        GoogleHelper(),
      ),
    );
  }

  if (!locator.isRegistered<SanityCms>()) {
    locator.registerLazySingleton<SanityCms>(
      () => SanityCms(
        projectId: 'd9v945zu',
        dataset: 'production',
      ),
    );
  }

  if (!locator.isRegistered<HermesService>()) {
    locator.registerLazySingleton<HermesService>(
      () => HermesService(),
    );
  }

  locator.registerFactory(() => StoreScreenModel());
}