import 'package:alpaca/sanity/sanity.dart';
import 'package:alpaca/screens/home/models/restaurant_overview_model.dart';
import 'package:alpaca/screens/store/store_screen_model.dart';
import 'package:alpaca/services/auth_service.dart';
import 'package:alpaca/services/auth_service_firebase.dart';
import 'package:alpaca/services/database_service.dart';
import 'package:alpaca/services/database_service_firestore.dart';
import 'package:alpaca/swagger/swagger.swagger.dart';
import 'package:chopper/chopper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  if (!locator.isRegistered<Swagger>()) {
    locator.registerLazySingleton<Swagger>(
      () => ChopperClient(
        baseUrl: 'http://localhost:5000',
        services: [Swagger.create()],
        converter: const JsonConverter(),
        interceptors: [
          (Request request) async {
            final user = await locator<AuthService>().getUser;
            final idToken = await user!.getIdToken();
            return applyHeader(request, 'Authorization', 'Bearer $idToken');
          }
        ],
      ).getService<Swagger>(),
    );
  }

  locator.registerFactory(() => RestaurantScreenModel());
  locator.registerFactory(() => StoreScreenModel());
}
