import 'package:alpaca/global.dart';
import 'package:alpaca/screens/onboarding/create/steps/insert_name.dart';
import 'package:alpaca/screens/onboarding/create/steps/phone_verification.dart';
import 'package:alpaca/screens/onboarding/widgets/onboarding_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

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
  int step = 0;
  int maxSteps = 4;

  @override
  Widget build(BuildContext context) {
    return OnboardingPageWrapper(
      backgroundColor: AlpacaColor.white100Color,
      statusBarStyle: SystemUiOverlayStyle.dark,
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
                      'Step ${step + 1}/$maxSteps',
                      style: Theme.of(context).textTheme.bodyText1!.merge(
                            const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    child: GestureDetector(
                      onTap: () => {Navigator.of(context).pop()},
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
                padding: const EdgeInsets.symmetric(vertical: 25.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 6,
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: maxSteps,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: (step - index) >= 0
                                  ? AlpacaColor.primary100
                                  : Colors.grey,
                            ),
                            margin: index < (maxSteps - 1)
                                ? const EdgeInsets.only(right: 10)
                                : EdgeInsets.zero,
                            width: MediaQuery.of(context).size.width * 0.21,
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
            child: IndexedStack(
              index: step,
              children: const [
                StepInsertName(),
                StepPhoneVerification(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
