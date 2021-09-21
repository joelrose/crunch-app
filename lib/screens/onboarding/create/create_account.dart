import 'package:flutter/material.dart';

class CreateAccountData {
  CreateAccountData({this.phoneNumber, required this.isSocialLogin});

  final String? phoneNumber;
  final bool isSocialLogin;
}

class OnboardingCreateAccountScreen extends StatefulWidget {
  const OnboardingCreateAccountScreen({Key? key, required this.data})
      : super(key: key);

  final CreateAccountData? data;

  @override
  _OnboardingCreateAccountScreenState createState() =>
      _OnboardingCreateAccountScreenState();
}

class _OnboardingCreateAccountScreenState
    extends State<OnboardingCreateAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
