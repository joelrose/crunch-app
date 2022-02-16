import 'package:alpaca/alpaca.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pickup/screens/home/home.dart';
import 'package:pickup/screens/onboarding/create_account/steps/insert_name.dart';
import 'package:pickup/screens/onboarding/create_account/steps/phone_verification.dart';
import 'package:pickup/screens/onboarding/create_account/steps/placeholder.dart';
import 'package:pickup/screens/onboarding/create_account/steps/set_password.dart';
import 'package:pickup/shared/models.dart';

class OnboardingCreateAccountScreen extends StatefulWidget {
  const OnboardingCreateAccountScreen({Key? key, required this.data})
      : super(key: key);

  static const route = '/onboarding/account/create';

  final CreateAccountData data;
  int get maxSteps => data.isSocialLogin ? 2 : 4;

  @override
  _OnboardingCreateAccountScreenState createState() =>
      _OnboardingCreateAccountScreenState();
}

class _OnboardingCreateAccountScreenState
    extends State<OnboardingCreateAccountScreen> {
  int step = 0;

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
                        '${'step'.tr()} ${step + 1}/${widget.maxSteps}',
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: AlpacaColor.darkNavyColor,
                            ),
                      ),
                    ),
                    if (!(step == 0 && !widget.data.isSocialLogin) &&
                        (step != 1 && !widget.data.isSocialLogin))
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
                                  (widget.data.isSocialLogin ? 0.445 : 0.21),
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
                        if (!widget.data.isSocialLogin) ...[
                          StepPhoneVerification(
                            phoneNumber: widget.data.phoneNumber!,
                            onFinish: nextStep,
                          ),
                          StepSetPassword(whichStepInCreateAccount: nextStep),
                        ],
                        StepInsertName(whichStepInCreateAccount: nextStep),
                        StepPlaceholder(
                          onFinish: () =>
                              Navigator.of(context).pushNamedAndRemoveUntil(
                            HomePage.route,
                            (route) => false,
                          ),
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