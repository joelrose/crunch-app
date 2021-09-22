import 'package:alpaca/global.dart';
import 'package:alpaca/services/auth_service.dart';
import 'package:alpaca/services/service_locator.dart';
import 'package:alpaca/shared/buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class StepPhoneVerification extends StatefulWidget {
  const StepPhoneVerification(
      {Key? key, required this.onFinish, required this.phoneNumber})
      : super(key: key);

  final void Function() onFinish;
  final String phoneNumber;

  @override
  _StepPhoneVerificationState createState() => _StepPhoneVerificationState();
}

class _StepPhoneVerificationState extends State<StepPhoneVerification> {
  AuthService auth = locator<AuthService>();
  String? _verificationId;

  @override
  void initState() {
    super.initState();

    sendVerification();
  }

  void sendVerification() async {
    await auth.firebaseAuth.verifyPhoneNumber(
      phoneNumber: widget.phoneNumber,
      codeSent: (String verificationId, int? resendToken) async {
        _verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
      },
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {
      },
      verificationFailed: (FirebaseAuthException error) {
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(right: size.width * 0.2),
          child: Text(
            "We've sent a verification Code to",
            style: theme.headline1!.merge(
              const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
                color: AlpacaColor.blackColor,
                height: 1.4,
                letterSpacing: -0.24,
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.phoneNumber,
            style: theme.headline1!.merge(
              const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
                color: AlpacaColor.primary100,
                height: 1.4,
                letterSpacing: -0.24,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 40, top: 10),
          child: Text(
            'Please check your messages and enter the code in the boxes below.',
            style: theme.subtitle1!.merge(
              const TextStyle(
                color: AlpacaColor.blackColor,
              ),
            ),
          ),
        ),
        PinCodeTextField(
          length: 6,
          animationType: AnimationType.scale,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(5),
            fieldHeight: 60,
            fieldWidth: size.width * 0.13,
            fieldOuterPadding: EdgeInsets.zero,
            activeFillColor: AlpacaColor.white100Color,
            selectedColor: const Color(0xffE8E8E8),
            selectedFillColor: AlpacaColor.white100Color,
            inactiveFillColor: AlpacaColor.white100Color,
            inactiveColor: const Color(0xffE8E8E8),
            activeColor: const Color(0xffE8E8E8),
          ),
          cursorColor: AlpacaColor.blackColor,
          textStyle: const TextStyle(
            color: Colors.black,
            fontSize: 22,
          ),
          animationDuration: const Duration(milliseconds: 300),
          enableActiveFill: true,
          onCompleted: (v) {
            _verifyNumber(v);
          },
          appContext: context,
          onChanged: (String value) {},
        ),
        Expanded(
          child: Container(),
        ),
        ActionButton(
          buttonText: 'Continue',
          onPressed: () {
            widget.onFinish();
          },
        ),
      ],
    );
  }

  void _verifyNumber(String code) async {
    // Create a PhoneAuthCredential with the code
    final credential = PhoneAuthProvider.credential(
      verificationId: _verificationId!,
      smsCode: code,
    );

    // Sign the user in (or link) with the credential
    await auth.firebaseAuth.signInWithCredential(credential);

    widget.onFinish();
  }
}
