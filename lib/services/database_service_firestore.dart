// import 'package:alpaca/services/auth_service.dart';
// import 'package:alpaca/services/database_service.dart';
// import 'package:alpaca/services/service_locator.dart';
// import 'package:alpaca/shared/userdata_model.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class DatabaseServiceFirestore implements DatabaseService {
//   DatabaseServiceFirestore(
//     FirebaseFirestore firestore,
//   ) {
//     _firestoreDb = firestore;
//   }

//   FirebaseFirestore _firestoreDb;

//   @override
//   Stream<UserDataModel> get getUserDataStreamData =>
//       UserData<UserDataModel>('userData', _firestoreDb).documentStream;

//   @override
//   Future<UserDataModel> getUserDataDocumentData() {
//     return UserData<UserDataModel>('userData', _firestoreDb).getDocument();
//   }

//   // @orride
//   Future<void> saveUserData(Map data) {
//     return UserData<UserDataModel>('userData', _firestoreDb).upsert(data);
//   }

//   @override
//   Future<bool> reportDocumentExists(String uid) {
//     final ref = _firestoreDb.doc('reports/$uid');
//     return ref.get().then((value) => value.exists);
//   }
// }

// class Document<T> {
//   Document(this.path, this.db) {
//     ref = db.doc(path);
//   }

//   final String path;
//   final FirebaseFirestore db;
//   DocumentReference ref;

//   Future<T> getData() {
//     return ref.get().then((value) => Global.models[T](value.data()) as T);
//   }

//   Future<void> upsert(Map data) {
//     return ref.set(Map<String, dynamic>.from(data), SetOptions(merge: true));
//   }

//   Future<bool> exists() {
//     return ref.get().then((value) => value.exists);
//   }
// }

// class UserData<T> {
//   UserData(this.collection, this.db);

//   final AuthService authService = locator<AuthService>();
//   final String collection;
//   final FirebaseFirestore db;

//   Stream<T> get documentStream {
//     return authService.user.switchMap((user) {
//       if (user != null) {
//         final Document<T> doc = Document<T>('$collection/${user.uid}', db);
//         return doc.streamData();
//       } else {
//         return Stream<T>.value(null);
//       }
//     });
//   }

//   Future<T> getDocument() async {
//     final User? user = await authService.getUser;
//     if (user != null) {
//       final Document doc = Document<T>('$collection/${user.uid}', db);
//       return doc.getData() as T;
//     } else {
//       return null;
//     }
//   }

//   Future<void> upsert(Map data) async {
//     final User user = await authService.getUser;
//     final Document<T> ref = Document('$collection/${user.uid}', db);
//     return ref.upsert(data);
//   }
// }
