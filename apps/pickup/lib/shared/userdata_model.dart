class UserDataModel {
  UserDataModel({
    required this.uid,
    required this.firstName,
    required this.lastName,
  });

  factory UserDataModel.fromMap(Map data) {
    return UserDataModel(
      uid: data['uid'] as String,
      firstName: data['firstname'] as String,
      lastName: data['lastname'] as String,
    );
  }

  final String uid;
  final String firstName;
  final String lastName;
}
