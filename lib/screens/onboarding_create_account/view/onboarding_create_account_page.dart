import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pickup/l10n/l10n.dart';
import 'package:pickup/screens/home/home.dart';
import 'package:pickup/screens/onboarding_create_account/widgets.dart/insert_name.dart';
import 'package:pickup/screens/onboarding_create_account/widgets.dart/phone_verification.dart';
import 'package:pickup/screens/onboarding_create_account/widgets.dart/placeholder.dart';
import 'package:pickup/screens/onboarding_create_account/widgets.dart/set_password.dart';
import 'package:pickup/shared/models/create_account_model.dart';

class OnboardingCreateAccountPage extends StatelessWidget {
  const OnboardingCreateAccountPage({Key? key}) : super(key: key);

  static Route<void> route({required CreateAccountData data, }) {
    return MaterialPageRoute(
      builder: (_) => BlocProvider(
        create: (_) => OnboardingCreateAccountCubit(isSignUp: isSignUp),
        child: const OnboardingCreateAccountPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingCreateAccountView();
  }
}

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
    return PageWrapper(
      backgroundColor: AlpacaColor.white100Color,
      statusBarStyle: SystemUiOverlayStyle.dark,
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Column(
          children: [
            _CreateAccountStatusBar(
              isSocialLogin: widget.data.isSocialLogin,
              maxSteps: widget.maxSteps,
              onBack: previousStep,
              step: step,
            ),
            _buildStack(),
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

  Widget _buildStack() {
    final media = MediaQuery.of(context);

    return Flexible(
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
                  onFinish: () => Navigator.of(context).pushNamedAndRemoveUntil(
                    HomePage.route,
                    (route) => false,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CreateAccountStatusBar extends StatelessWidget {
  const _CreateAccountStatusBar({
    Key? key,
    required this.step,
    required this.maxSteps,
    required this.isSocialLogin,
    required this.onBack,
  }) : super(key: key);

  final int step;
  final int maxSteps;
  final bool isSocialLogin;
  final void Function() onBack;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                '${context.l10n.step} ${step + 1}/$maxSteps',
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      color: AlpacaColor.darkNavyColor,
                    ),
              ),
            ),
            if (!(step == 0 && !isSocialLogin) && (step != 1 && !isSocialLogin))
              Positioned(
                left: 0,
                child: GestureDetector(
                  onTap: () =>
                      step == 0 ? Navigator.of(context).pop() : onBack(),
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
                  itemCount: maxSteps,
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
                          (isSocialLogin ? 0.445 : 0.21),
                      height: 8,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  BorderRadius _getBorderRadius(int index) {
    if (index == 0) {
      return const BorderRadius.horizontal(
        left: Radius.circular(20),
      );
    } else if ((index + 1) == maxSteps) {
      return const BorderRadius.horizontal(
        right: Radius.circular(20),
      );
    }

    return BorderRadius.zero;
  }
}
