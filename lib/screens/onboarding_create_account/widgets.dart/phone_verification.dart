import 'dart:async';

import 'package:alpaca/alpaca.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_repository/hermes_repository.dart';
import 'package:pickup/l10n/l10n.dart';
import 'package:pickup/screens/home/home.dart';
import 'package:pickup/screens/onboarding_create_account/cubit/onboarding_create_account_cubit.dart';
import 'package:pickup/shared/show_async_loading.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class StepPhoneVerification extends StatefulWidget {
  const StepPhoneVerification({
    Key? key,
    required this.phoneNumber,
  }) : super(key: key);

  final String phoneNumber;

  @override
  _StepPhoneVerificationState createState() => _StepPhoneVerificationState();
}

class _StepPhoneVerificationState extends State<StepPhoneVerification> {
  final TextEditingController _textController = TextEditingController();

  final StreamController<ErrorAnimationType> _errorController =
      StreamController<ErrorAnimationType>();

  bool _hasError = false;
  int _start = 0;

  String? _verificationId;

  late Timer? _timer;

  @override
  void initState() {
    super.initState();

    _sendVerification();
  }

  @override
  void dispose() {
    _errorController.close();
    _timer?.cancel();

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
    await context
        .read<AuthenticationRepository>()
        .firebaseAuth
        .verifyPhoneNumber(
          phoneNumber: widget.phoneNumber,
          codeSent: (String verificationId, int? resendToken) async {
            _verificationId = verificationId;

            startTimer();

            LoadingUtils.hide();
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
          verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {},
          verificationFailed: (FirebaseAuthException error) {
            FirebaseCrashlytics.instance.recordError(error, null);
          },
        );
  }

  Future<void> _verifyNumber(String code) async {
    final credential = PhoneAuthProvider.credential(
      verificationId: _verificationId ?? '',
      smsCode: code,
    );

    try {
      await context
          .read<AuthenticationRepository>()
          .firebaseAuth
          .signInWithCredential(credential);

      if (!mounted) return;

      final account =
          await context.read<HermesRepository>().client.apiUsersGet();

      if (!mounted) return;

      if (account.isSuccessful) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          HomePage.route,
          (route) => false,
        );
      } else {
        context.read<OnboardingCreateAccountCubit>().nextStep();
      }
    } catch (exception) {
      _errorController.add(
        ErrorAnimationType.shake,
      );
      setState(() {
        _hasError = true;
      });

      _textController.clear();
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
            context.l10n.phoneVerificationTitle,
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
            context.l10n.phoneVerificationDescription,
            style: theme.headline5,
          ),
        ),
        _buildPinCodeTextField(context, size.width),
        if (_hasError)
          Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 10),
            child: Text(
              context.l10n.phoneVerificationFailed,
              style: theme.headline4!.copyWith(
                color: Colors.red,
              ),
            ),
          ),
        GestureDetector(
          onTap: () {
            if (_start == 0) {
              _textController.clear();
              _sendVerification();

              setState(() {
                _hasError = false;
              });
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
                  _start != 0
                      ? '${context.l10n.resendCode} ($_start)'
                      : context.l10n.resendCode,
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

  Widget _buildPinCodeTextField(BuildContext context, double width) {
    return PinCodeTextField(
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
        fieldWidth: width * 0.13,
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
      enableActiveFill: true,
      onCompleted: (v) {
        _verifyNumber(v);
      },
      appContext: context,
      onChanged: (String value) {},
    );
  }
}
