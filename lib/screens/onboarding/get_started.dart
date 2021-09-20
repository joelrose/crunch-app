import 'package:alpaca/routes.dart';
import 'package:alpaca/screens/onboarding/onboarding_wrapper.dart';
import 'package:alpaca/shared/buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return OnboardingPageWrapper(
      padding: EdgeInsets.zero,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Placeholder(
            fallbackHeight: MediaQuery.of(context).size.height * 0.5,
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
                  'Welcome aboard!',
                  style: theme.headline1,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40, top: 10),
                  child: Text(
                    'We are very excited to have you with us, let’s get started.',
                    style: theme.subtitle1,
                  ),
                ),
                ActionButton(
                  buttonText: 'Get Started',
                  onPressed: () =>
                      {Navigator.of(context).pushNamed(welcomeRoute)},
                  isPrimaryButton: false,
                ),
                ActionButton(
                  buttonText: 'I already have an account',
                  onPressed: () => {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
