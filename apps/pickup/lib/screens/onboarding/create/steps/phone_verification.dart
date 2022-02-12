import 'dart:async';

import 'package:alpaca/alpaca.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pickup/services/auth_service.dart';
import 'package:pickup/services/service_locator.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class StepPhoneVerification extends StatefulWidget {
  const StepPhoneVerification({
    Key? key,
    required this.onFinish,
    required this.phoneNumber,
  }) : super(key: key);

  final void Function() onFinish;
  final String phoneNumber;

  @override
  _StepPhoneVerificationState createState() => _StepPhoneVerificationState();
}

class _StepPhoneVerificationState extends State<StepPhoneVerification> {
  AuthService auth = locator<AuthService>();
  late String _verificationId;

  final TextEditingController _textController = TextEditingController();

  late bool _hasError = false;
  late StreamController<ErrorAnimationType> _errorController;

  late Timer _timer;
  late int _start;

  @override
  void initState() {
    super.initState();

    _errorController = StreamController<ErrorAnimationType>();

    _sendVerification();
  }

  @override
  void dispose() {
    _errorController.close();
    _timer.cancel();

    super.dispose();
  }

  void startTimer() {
    _start = 30;
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  Future<void> _sendVerification() async {
    startTimer();
    await auth.firebaseAuth.verifyPhoneNumber(
      phoneNumber: widget.phoneNumber,
      codeSent: (String verificationId, int? resendToken) async {
        _verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {},
      verificationFailed: (FirebaseAuthException error) {},
    );
  }

  Future<void> _verifyNumber(String code) async {
    final credential = PhoneAuthProvider.credential(
      verificationId: _verificationId,
      smsCode: code,
    );

    try {
      await auth.firebaseAuth.signInWithCredential(credential);

      widget.onFinish();
    } catch (exception) {
      _errorController.add(
        ErrorAnimationType.shake,
      );
      setState(() {
        _hasError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            right: size.width * 0.2,
            top: size.height * 0.03,
          ),
          child: Text(
            "We've sent a verification Code to",
            style: theme.headline1!.copyWith(
              color: AlpacaColor.blackColor,
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.phoneNumber,
            style: theme.headline1!.copyWith(
              color: AlpacaColor.primary100,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 40, top: 10),
          child: Text(
              'Please check your messages and enter the code in the boxes below.',
              style: theme.headline5),
        ),
        PinCodeTextField(
          length: 6,
          animationType: AnimationType.scale,
          keyboardType: TextInputType.number,
          controller: _textController,
          errorAnimationController: _errorController,
          autoFocus: true,
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
          textStyle: Theme.of(context).textTheme.headline2,
          animationDuration: const Duration(milliseconds: 300),
          enableActiveFill: true,
          onCompleted: (v) {
            _verifyNumber(v);
          },
          appContext: context,
          onChanged: (String value) {},
        ),
        if (_hasError)
          Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 10),
            child: Text(
              'The entered code is not valid, please try again!',
              style: theme.headline4!.copyWith(
                color: Colors.red,
              ),
            ),
          ),
        GestureDetector(
          onTap: () {
            if (_start == 0) {
              _sendVerification();
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(
                    Icons.swap_horiz,
                    color: _start != 0
                        ? AlpacaColor.darkGreyColor
                        : AlpacaColor.primary100,
                  ),
                ),
                Text(
                  _start != 0 ? 'Resend code! ($_start)' : 'Resend code!',
                  style: theme.headline4!.copyWith(
                    color: _start != 0
                        ? AlpacaColor.darkGreyColor
                        : AlpacaColor.primary100,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
