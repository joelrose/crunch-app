import 'package:alpaca/global.dart';
import 'package:alpaca/routes.dart';
import 'package:alpaca/screens/onboarding/create/steps/insert_name.dart';
import 'package:alpaca/screens/onboarding/create/steps/phone_verification.dart';
import 'package:alpaca/screens/onboarding/create/steps/placeholder.dart';
import 'package:alpaca/screens/onboarding/create/steps/set_password.dart';
import 'package:alpaca/shared/page_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class CreateAccountData {
  CreateAccountData({this.phoneNumber, required this.isSocialLogin});

  final String? phoneNumber;
  final bool isSocialLogin;
}

class OnboardingCreateAccountScreen extends StatefulWidget {
  OnboardingCreateAccountScreen({Key? key, required this.data})
      : super(key: key) {
    maxSteps = data!.isSocialLogin ? 2 : 4;
  }

  final CreateAccountData? data;
  late int maxSteps;

  @override
  _OnboardingCreateAccountScreenState createState() =>
      _OnboardingCreateAccountScreenState();
}

class _OnboardingCreateAccountScreenState
    extends State<OnboardingCreateAccountScreen> {
  int step = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    return PageWrapper(
      backgroundColor: AlpacaColor.white100Color,
      statusBarStyle: SystemUiOverlayStyle.dark,
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Column(
          children: [
            Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Step ${step + 1}/${widget.maxSteps}',
                        style: Theme.of(context).textTheme.bodyText1!.merge(
                              const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                      ),
                    ),
                    if (!(step == 0 && !widget.data!.isSocialLogin) &&
                        (step != 1 && !widget.data!.isSocialLogin))
                      Positioned(
                        left: 0,
                        child: GestureDetector(
                          onTap: () => {
                            if (step == 0)
                              {Navigator.of(context).pop()}
                            else
                              {previousStep()}
                          },
                          child: const Icon(
                            Icons.arrow_back_ios,
                            size: 20,
                            color: AlpacaColor.blackColor,
                          ),
                        ),
                      )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25.0, bottom: 25),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 5,
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.maxSteps,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: _getBorderRadius(index),
                                color: (step - index) >= 0
                                    ? AlpacaColor.primary100
                                    : AlpacaColor.lightGreyColor90,
                              ),
                              margin: EdgeInsets.zero,
                              width: MediaQuery.of(context).size.width *
                                  (widget.data!.isSocialLogin ? 0.445 : 0.21),
                              height: 8,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Flexible(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(
                  parent: NeverScrollableScrollPhysics(),
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: media.size.width,
                    minHeight: media.size.height -
                        140 -
                        media.viewPadding.bottom -
                        media.viewPadding.top,
                  ),
                  child: IntrinsicHeight(
                    child: IndexedStack(
                      index: step,
                      children: [
                        if (!widget.data!.isSocialLogin) ...[
                          StepPhoneVerification(
                            phoneNumber: widget.data!.phoneNumber!,
                            onFinish: nextStep,
                          ),
                          StepSetPassword(whichStepInCreateAccount: nextStep),
                        ],
                        StepInsertName(whichStepInCreateAccount: nextStep),
                        StepPlaceholder(
                          onFinish: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              homeRoute,
                              (route) => false,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void nextStep() {
    setState(() {
      step++;
    });
  }

  void previousStep() {
    setState(() {
      step--;
    });
  }

  BorderRadius _getBorderRadius(int index) {
    if (index == 0) {
      return const BorderRadius.horizontal(
        left: Radius.circular(20),
      );
    } else if ((index + 1) == widget.maxSteps) {
      return const BorderRadius.horizontal(
        right: Radius.circular(20),
      );
    }

    return BorderRadius.zero;
  }
}
