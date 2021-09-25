import 'package:alpaca/sanity/sanity.dart';
import 'package:alpaca/screens/home/models/restaurant_overview_model.dart';
import 'package:alpaca/screens/store/store_screen_model.dart';
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

  if (!locator.isRegistered<SanityCms>()) {
    locator.registerLazySingleton<SanityCms>(
      () => SanityCms(
        projectId: 'd9v945zu',
        dataset: 'production',
      ),
    );
  }

  locator.registerFactory(() => RestaurantScreenModel());
  locator.registerFactory(() => StoreScreenModel());
}
