import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:pickup/l10n/l10n.dart';
import 'package:pickup/screens/onboarding/account/account.dart';
import 'package:pickup/screens/onboarding_explanation/onboarding_explanation.dart';

class OnboardingWelcomePage extends StatelessWidget {
  const OnboardingWelcomePage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute(
      builder: (_) => const OnboardingWelcomePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const OnboardingWelcomeView();
  }
}

class OnboardingWelcomeView extends StatelessWidget {
  const OnboardingWelcomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      padding: EdgeInsets.zero,
      backgroundColor: AlpacaColor.primary100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const _Image(),
          Container(
            alignment: Alignment.bottomCenter,
            child: const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 18.0,
              ),
              child: _Content(),
            ),
          ),
        ],
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.welcomeTitle,
          style: theme.headline1!.copyWith(
            fontSize: 36,
            color: AlpacaColor.white100Color,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 40, top: 10),
          child: Text(
            context.l10n.welcomeSubtitle,
            style: theme.headline5!.copyWith(
              color: AlpacaColor.white100Color,
            ),
          ),
        ),
        ActionButton(
          key: const Key('onboarding_welcome.primary'),
          buttonText: context.l10n.welcomePrimaryButtonText,
          onPressed: () => Navigator.of(context).push(
            OnboardingExplanationPage.route(),
          ),
          isPrimaryButton: false,
        ),
        ActionButton(
          key: const Key('onboarding_welcome.secondary'),
          buttonText: context.l10n.welcomeSecondaryButtonText,
          onPressed: () => Navigator.of(context).pushNamed(
            OnboardingAccountScreen.route,
            arguments: false,
          ),
        ),
      ],
    );
  }
}

class _Image extends StatelessWidget {
  const _Image({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.50,
      child: Image.asset(
        'assets/onboarding/splash-graphic.png',
        fit: BoxFit.cover,
        alignment: Alignment.bottomCenter,
      ),
    );
  }
}
