import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pickup/l10n/l10n.dart';
import 'package:pickup/screens/home/home.dart';

class StepPlaceholder extends StatelessWidget {
  const StepPlaceholder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(right: size.width * 0.2),
          child: Text(
            context.l10n.onboardingPlaceholderTitle,
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
        Padding(
          padding: const EdgeInsets.only(bottom: 40, top: 10),
          child: Text(
            context.l10n.onboardingPlaceholderText,
            style: theme.headline5,
          ),
        ),
        SvgPicture.asset(
          'assets/onboarding/placeholder.svg',
          height: 250,
        ),
        Container(height: 40),
        ActionButton(
          buttonText: context.l10n.onboardingPlaceholderCTA,
          onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
            HomePage.route,
            (route) => false,
          ),
        ),
      ],
    );
  }
}
