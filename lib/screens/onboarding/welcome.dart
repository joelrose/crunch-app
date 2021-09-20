import 'package:alpaca/global.dart';
import 'package:alpaca/routes.dart';
import 'package:alpaca/screens/onboarding/onboarding_wrapper.dart';
import 'package:alpaca/shared/buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return OnboardingPageWrapper(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => {Navigator.of(context).pop()},
                      child: const Icon(
                        Icons.arrow_back_ios,
                        size: 20,
                        color: AlpacaColor.white100Color,
                      ),
                    ),
                    Text(
                      'Skip',
                      style: GoogleFonts.inter(
                        color: AlpacaColor.white100Color,
                        fontSize: 16,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w600,
                        height: 1,
                      ),
                    ),
                  ],
                ),
              ),
              Placeholder(
                fallbackHeight: MediaQuery.of(context).size.height * 0.4,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Title goes here',
                style: theme.headline1,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 40, top: 10),
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sit volutpat at lacus id mus. Sit vitae, arcu consequat quam ut ut. ',
                  style: theme.subtitle1,
                ),
              ),
              const SizedBox(height: 25),
              ActionButton(
                buttonText: 'Next',
                onPressed: () =>
                    {Navigator.of(context).pushNamed(createAccountRoute)},
                isPrimaryButton: false,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
