import 'package:alpaca/alpaca.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pickup/screens/onboarding/account/widgets/social_onboarding.dart';
import 'package:pickup/shared/models.dart';
import 'package:pickup/shared/routes.dart';

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
              style: theme.subtitle1,
            ),
          ),
          TextField(
            controller: _textController,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.phone,
            autocorrect: false,
            cursorColor: AlpacaColor.white100Color,
            scrollPadding: const EdgeInsets.only(bottom: 30),
            decoration: InputDecoration(
              suffixIcon: GestureDetector(
                onTap: () async {
                  Navigator.of(context).pushNamed(
                    onboardingCreateAccountRoute,
                    arguments: CreateAccountData(
                      phoneNumber: _textController.text,
                      isSocialLogin: false,
                    ),
                  );
                },
                child: const Icon(
                  Icons.arrow_forward,
                  color: AlpacaColor.white80Color,
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
              hintText: 'Please enter your phone number',
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
                  style: theme.bodyText2!
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
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 10,
            ),
            child: Text(
              'onboarding.agreeToTerms'.tr(),
              textAlign: TextAlign.center,
              style:
                  theme.bodyText2!.copyWith(color: AlpacaColor.white100Color),
            ),
          )
        ],
      ),
    );
  }
}
