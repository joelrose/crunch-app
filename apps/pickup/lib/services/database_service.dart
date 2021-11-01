import 'package:pickup/shared/userdata_model.dart';

abstract class DatabaseService {
  Stream<UserDataModel> get getUserDataStreamData;
  Future<UserDataModel> getUserDataDocumentData();
  Future<void> saveUserData(Map data);
  Future<bool> reportDocumentExists(String uid);
}
