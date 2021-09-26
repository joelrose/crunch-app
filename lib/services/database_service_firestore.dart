import 'package:alpaca/services/auth_service.dart';
import 'package:alpaca/services/database_service.dart';
import 'package:alpaca/services/service_locator.dart';
import 'package:alpaca/shared/userdata_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class DatabaseServiceFirestore implements DatabaseService {
  DatabaseServiceFirestore(
    FirebaseFirestore firestore,
  ) {
    _firestoreDb = firestore;
  }

  final AuthService authService = locator<AuthService>();

  late FirebaseFirestore _firestoreDb;

  @override
  Stream<UserDataModel> get getUserDataStreamData {
    return authService.user.switchMap((user) {
      if (user != null) {
        final stream = _firestoreDb.doc('users/${user.uid}').snapshots().map(
              (event) =>
                  UserDataModel.fromMap(event.data()!),
            );

        return stream;
      } else {
        return const Stream.empty();
      }
    });
  }

  @override
  Future<UserDataModel> getUserDataDocumentData() async {
    final User? user = await authService.getUser;
    if (user != null) {
      final model = _firestoreDb.doc('users/${user.uid}').get().then(
            (value) =>
                UserDataModel.fromMap(value.data()!),
          );
      return model;
    } else {
      return Future.error('User not authenticated');
    }
  }

  @override
  Future<void> saveUserData(Map data) async {
    final User? user = await authService.getUser;
    return _firestoreDb
        .doc('users/${user!.uid}')
        .set(Map<String, dynamic>.from(data), SetOptions(merge: true));
  }

  @override
  Future<bool> reportDocumentExists(String uid) {
    final ref = _firestoreDb.doc('users/$uid');
    return ref.get().then((value) => value.exists);
  }
}
