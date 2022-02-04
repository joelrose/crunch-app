import 'package:alpaca/alpaca.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pickup/shared/routes.dart';

class OnboardingWelcomeScreen extends StatelessWidget {
  const OnboardingWelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return PageWrapper(
      padding: EdgeInsets.zero,
      backgroundColor: AlpacaColor.primary100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'assets/onboarding/splash-graphic.png',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.5,
            fit: BoxFit.scaleDown,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 15.0,
              horizontal: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'onboarding_welcome.title'.tr(),
                  style: theme.headline1!.copyWith(
                    color: AlpacaColor.white100Color,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40, top: 10),
                  child: Text(
                    'onboarding_welcome.subtitle'.tr(),
                    style: theme.subtitle1,
                  ),
                ),
                ActionButton(
                  buttonText: 'onboarding_welcome.primaryButtonText'.tr(),
                  onPressed: () => {
                    Navigator.of(context).pushNamed(onboardingExplanationRoute),
                  },
                  isPrimaryButton: false,
                ),
                ActionButton(
                  buttonText: 'onboarding_welcome.secondaryButtonText'.tr(),
                  onPressed: () => {
                    Navigator.of(context).pushNamed(
                      onboardingAccountRoute,
                      arguments: false,
                    ),
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
