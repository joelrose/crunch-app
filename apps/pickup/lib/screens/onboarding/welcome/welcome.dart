import 'package:alpaca/alpaca.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pickup/screens/onboarding/account/account.dart';
import 'package:pickup/screens/onboarding/explanation/explanation.dart';

class OnboardingWelcomeScreen extends StatelessWidget {
  const OnboardingWelcomeScreen({Key? key}) : super(key: key);

  static const route = '/onboarding/welcome';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return PageWrapper(
      padding: EdgeInsets.zero,
      backgroundColor: AlpacaColor.primary100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.60,
            child: Image.asset(
              'assets/onboarding/splash-graphic.png',
              fit: BoxFit.cover,
              alignment: Alignment.bottomCenter,
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'onboarding_welcome.title'.tr(),
                    style: theme.headline1!.copyWith(
                      fontSize: 36,
                      color: AlpacaColor.white100Color,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40, top: 10),
                    child: Text(
                      'onboarding_welcome.subtitle'.tr(),
                      style: theme.headline5!.copyWith(
                        color: AlpacaColor.white100Color,
                      ),
                    ),
                  ),
                  ActionButton(
                    buttonText: 'onboarding_welcome.primaryButtonText'.tr(),
                    onPressed: () => Navigator.of(context).pushNamed(
                      OnboardingExplanationScreen.route,
                    ),
                    isPrimaryButton: false,
                  ),
                  ActionButton(
                    buttonText: 'onboarding_welcome.secondaryButtonText'.tr(),
                    onPressed: () => Navigator.of(context).pushNamed(
                      OnboardingAccountScreen.route,
                      arguments: false,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
