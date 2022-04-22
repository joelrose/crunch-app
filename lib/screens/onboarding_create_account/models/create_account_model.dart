import 'package:equatable/equatable.dart';

class CreateAccountData extends Equatable {
  const CreateAccountData({this.phoneNumber, required this.isSocialLogin});

  final String? phoneNumber;
  final bool isSocialLogin;

  @override
  List<Object?> get props => [phoneNumber, isSocialLogin];
}
