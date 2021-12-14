import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pickup/screens/home/models/restaurant_overview_model.dart';
import 'package:pickup/screens/store/store_screen_model.dart';
import 'package:pickup/services/auth_service.dart';
import 'package:pickup/services/auth_service_firebase.dart';
import 'package:pickup/services/database_service.dart';
import 'package:pickup/services/database_service_firestore.dart';
import 'package:pickup/services/hermes_service.dart';
import 'package:sanity/sanity.dart';

GetIt locator = GetIt.instance;

Future<void> setupServiceLocator() async {
  await Firebase.initializeApp();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  if (!locator.isRegistered<AuthService>()) {
    locator.registerLazySingleton<AuthService>(
      () => AuthServiceFirebase(
        FirebaseAuth.instance,
        GoogleSignIn(),
        GoogleHelper(),
      ),
    );
  }

  if (!locator.isRegistered<DatabaseService>()) {
    locator.registerLazySingleton<DatabaseService>(
      () => DatabaseServiceFirestore(firestore),
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

  locator.registerFactory(() => RestaurantScreenModel());
  locator.registerFactory(() => StoreScreenModel());
}
