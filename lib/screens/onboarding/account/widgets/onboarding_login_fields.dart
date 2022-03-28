import 'package:alpaca/alpaca.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pickup/screens/onboarding/account/widgets/social_onboarding.dart';
import 'package:pickup/screens/onboarding/create_account/create_account.dart';
import 'package:pickup/shared/country_emoji.dart';
import 'package:pickup/shared/models/create_account_model.dart';
import 'package:pickup/shared/phone_number_verification.dart';
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

  String selectedPhoneCode = '+49';
  String selectedCountryCode = 'DE';

  bool isValidPhoneNumber = false;

  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildGreeting(),
          _buildTextSignInOrUp(),
          _buildTextField(),
          _buildOrLine(),
          SocialOnboarding(isSignUp: widget.isSignUp),
          _buildAgreeToTerms()
        ],
      ),
    );
  }

  Widget _buildGreeting() {
    return Text(
      widget.isSignUp
          ? 'onboarding.createAccount'.tr()
          : 'onboarding.welcomeBack'.tr(),
      style: Theme.of(context).textTheme.headline1!.copyWith(
            color: AlpacaColor.white100Color,
          ),
    );
  }

  Widget _buildTextSignInOrUp() {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 30,
        top: 10,
        right: 40,
      ),
      child: Text(
        widget.isSignUp
            ? 'onboarding.signUpCTA'.tr()
            : 'onboarding.signInCTA'.tr(),
        style: Theme.of(context)
            .textTheme
            .headline5!
            .copyWith(color: AlpacaColor.white100Color),
      ),
    );
  }

  Widget _buildTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Text(
            'Mobile number',
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: AlpacaColor.white100Color),
          ),
        ),
        Form(
          key: _form,
          child: TextFormField(
            controller: _textController,
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  color: AlpacaColor.white100Color,
                ),
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.phone,
            autocorrect: false,
            cursorColor: AlpacaColor.white100Color,
            scrollPadding: const EdgeInsets.only(bottom: 30),
            onChanged: (text) async {
              final phoneNumber = selectedPhoneCode + text;

              isValidPhoneNumber = await phoneNumber.isValidPhoneNumber();
            },
            validator: (text) {
              if (!isValidPhoneNumber) {
                return 'Please enter a valid german mobile number!';
              }
              return null;
            },
            decoration: InputDecoration(
              prefixIconConstraints: BoxConstraints(
                maxWidth: 40 + selectedPhoneCode.length * 10,
              ),
              prefixIcon: _buildTextFieldPrefix(),
              suffixIcon: _buildTextFieldSuffix(),
              contentPadding: EdgeInsets.zero,
              border: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: AlpacaColor.primary80,
                ),
              ),
              fillColor: AlpacaColor.primary80,
              hintText: 'Mobile number',
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
              errorStyle: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: AlpacaColor.white100Color),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextFieldSuffix() {
    return GestureDetector(
      onTap: () async {
        final phoneNumber = selectedPhoneCode + _textController.text;

        if (_form.currentState!.validate()) {
          Navigator.of(context).pushNamed(
            OnboardingCreateAccountScreen.route,
            arguments: CreateAccountData(
              phoneNumber: phoneNumber,
              isSocialLogin: false,
            ),
          );
        } else {}
      },
      child: ClipRRect(
        borderRadius: const BorderRadius.horizontal(right: Radius.circular(8)),
        child: Container(
          color: AlpacaColor.white100Color,
          child: const Icon(
            Icons.arrow_forward,
            color: AlpacaColor.primary100,
            size: 15,
          ),
        ),
      ),
    );
  }

  Widget _buildTextFieldPrefix() {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () async {},
      child: ClipRRect(
        borderRadius: const BorderRadius.horizontal(left: Radius.circular(8)),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(bottom: 2),
          child: Row(
            children: [
              Container(width: 8),
              Text(
                Utils.countryCodeToEmoji(selectedCountryCode),
                style: Theme.of(context).textTheme.headline2,
              ),
              Container(width: 6),
              Text(
                selectedPhoneCode,
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: AlpacaColor.white100Color),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrLine() {
    return Row(
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
            style: Theme.of(context)
                .textTheme
                .headline5!
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
    );
  }

  Widget _buildAgreeToTerms() {
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
}
