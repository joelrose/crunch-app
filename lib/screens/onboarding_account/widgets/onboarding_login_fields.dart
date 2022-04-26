import 'package:alpaca/alpaca.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_repository/hermes_repository.dart';
import 'package:pickup/l10n/l10n.dart';
import 'package:pickup/screens/onboarding_account/cubit/onboarding_account_cubit.dart';
import 'package:pickup/screens/onboarding_account/widgets/widgets.dart';
import 'package:pickup/screens/onboarding_create_account/onboarding_create_account.dart';
import 'package:pickup/shared/country_emoji.dart';
import 'package:pickup/shared/phone_number_verification.dart';
import 'package:pickup/shared/show_async_loading.dart';
import 'package:url_launcher/url_launcher_string.dart';

class OnboardingLoginFields extends StatefulWidget {
  const OnboardingLoginFields({Key? key}) : super(key: key);

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
    final isSignUp =
        context.select((OnboardingAccountCubit cubit) => cubit.state.isSignUp);

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            isSignUp ? context.l10n.createAccount : context.l10n.welcomeBack,
            style: Theme.of(context).textTheme.headline1!.copyWith(
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
              isSignUp ? context.l10n.signUpCTA : context.l10n.signInCTA,
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: AlpacaColor.white100Color),
            ),
          ),
          _buildTextField(),
          _buildOrLine(),
          const SocialOnboarding(),
          const _AgreeToTerms(),
        ],
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
            context.l10n.mobileNumber,
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
                return context.l10n.mobileNumberValidationError;
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
              hintText: context.l10n.mobileNumber,
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
          LoadingUtils.show();

          final hermesRepository = context.read<HermesRepository>();

          final response = await hermesRepository.client
              .apiWhitelistuserPost(body: phoneNumber);

          if (response.isSuccessful && response.body == true) {
            Navigator.of(context).pushAndRemoveUntil(
              OnboardingCreateAccountPage.route(
                data: CreateAccountData(
                  phoneNumber: phoneNumber,
                  isSocialLogin: false,
                ),
              ),
              (route) => false,
            );
          } else {
            final snackBar = SnackBar(
              content: Text(context.l10n.notOnWhitelist),
            );

            if (!mounted) {
              return;
            }

            LoadingUtils.hide();

            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
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
            context.l10n.or,
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
}

class _AgreeToTerms extends StatelessWidget {
  const _AgreeToTerms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 10,
      ),
      child: Container(
        alignment: Alignment.center,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: context.l10n.agreeToTerms,
              children: [
                TextSpan(
                  text: ' ${context.l10n.termsOfService}',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => launchUrlString(
                          'https://crunch-app.notion.site/Imprint-e6703f9d44be4d0f9ee0992953056d74',
                        ),
                  style: const TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
                TextSpan(text: ' ${context.l10n.and} '),
                TextSpan(
                  text: context.l10n.privacyPolicy,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => launchUrlString(
                          'https://crunch-app.notion.site/Imprint-e6703f9d44be4d0f9ee0992953056d74',
                        ),
                  style: const TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
                TextSpan(text: context.l10n.agreeToTermsEnd),
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
