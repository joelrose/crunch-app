import 'package:alpaca/alpaca.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pickup/screens/onboarding/account/widgets/social_onboarding.dart';
import 'package:pickup/screens/onboarding/create/create_account.dart';
import 'package:pickup/shared/models.dart';
import 'package:url_launcher/url_launcher.dart';

class OnboardingLoginFields extends StatefulWidget {
  const OnboardingLoginFields({Key? key, required this.isSignUp})
      : super(key: key);

  final bool isSignUp;

  @override
  _OnboardingInputFieldsState createState() => _OnboardingInputFieldsState();
}

class _OnboardingInputFieldsState extends State<OnboardingLoginFields> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 30,
        horizontal: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            widget.isSignUp
                ? 'onboarding.createAccount'.tr()
                : 'onboarding.welcomeBack'.tr(),
            style: theme.headline1!.copyWith(
              color: AlpacaColor.white100Color,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 30,
              top: 10,
              right: 40,
            ),
            child: Text(
              widget.isSignUp
                  ? 'onboarding.signUpCTA'.tr()
                  : 'onboarding.signInCTA'.tr(),
              style:
                  theme.headline5!.copyWith(color: AlpacaColor.white100Color),
            ),
          ),
          buildTextField(),
          Row(
            children: [
              const Expanded(
                child: Divider(
                  color: AlpacaColor.white100Color,
                  height: 40,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'or'.tr(),
                  style: theme.headline5!
                      .copyWith(color: AlpacaColor.white100Color),
                ),
              ),
              const Expanded(
                child: Divider(
                  color: AlpacaColor.white100Color,
                  height: 40,
                ),
              ),
            ],
          ),
          SocialOnboarding(isSignUp: widget.isSignUp),
          buildAgreeToTerms()
        ],
      ),
    );
  }

  Widget buildAgreeToTerms() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 10,
      ),
      child: Container(
        alignment: Alignment.center,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.65,
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'By continuing, I agree to Crunch’s ',
              children: [
                TextSpan(
                  text: 'Terms of service',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => launch(
                          'https://crunch-app.notion.site/Imprint-e6703f9d44be4d0f9ee0992953056d74',
                        ),
                  style: const TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
                const TextSpan(text: ' and'),
                TextSpan(
                  text: ' Privacy Policy.',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => launch(
                          'https://crunch-app.notion.site/Imprint-e6703f9d44be4d0f9ee0992953056d74',
                        ),
                  style: const TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: AlpacaColor.white100Color),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Text(
            'Phone number',
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: AlpacaColor.white100Color),
          ),
        ),
        TextField(
          controller: _textController,
          style: Theme.of(context).textTheme.headline5!.copyWith(
                color: AlpacaColor.white100Color,
              ),
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.phone,
          autocorrect: false,
          cursorColor: AlpacaColor.white100Color,
          scrollPadding: const EdgeInsets.only(bottom: 30),
          decoration: InputDecoration(
            suffixIcon: GestureDetector(
              onTap: () async {
                // TODO: Validation
                Navigator.of(context).pushNamed(
                  OnboardingCreateAccountScreen.route,
                  arguments: CreateAccountData(
                    phoneNumber: _textController.text,
                    isSocialLogin: false,
                  ),
                );
              },
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.horizontal(right: Radius.circular(8)),
                child: Container(
                  color: AlpacaColor.white100Color,
                  child: const Icon(
                    Icons.arrow_forward,
                    color: AlpacaColor.primary100,
                    size: 15,
                  ),
                ),
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15.0,
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: AlpacaColor.primary80,
              ),
            ),
            fillColor: AlpacaColor.primary80,
            hintText: 'Phone number',
            filled: true,
            hintStyle: const TextStyle(
              color: AlpacaColor.white80Color,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AlpacaColor.primary80,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AlpacaColor.primary80,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}
