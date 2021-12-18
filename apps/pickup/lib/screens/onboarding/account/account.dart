import 'package:alpaca/alpaca.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pickup/screens/onboarding/create/create_account.dart';
import 'package:pickup/services/account_status.dart';
import 'package:pickup/services/auth_service.dart';
import 'package:pickup/services/service_locator.dart';
import 'package:pickup/shared/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingAccountScreen extends StatefulWidget {
  const OnboardingAccountScreen({Key? key, required this.isSignUp})
      : super(key: key);

  final bool isSignUp;

  @override
  State<OnboardingAccountScreen> createState() =>
      _OnboardingAccountScreenState();
}

class _OnboardingAccountScreenState extends State<OnboardingAccountScreen> {
  final AuthService auth = locator<AuthService>();

  late TextEditingController _textController;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return PageWrapper(
      padding: EdgeInsets.zero,
      backgroundColor: AlpacaColor.primary100,
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          _scrollController.jumpTo(0);
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const ClampingScrollPhysics(
            parent: NeverScrollableScrollPhysics(),
          ),
          child: SizedBox(
            height: (MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top) *
                0.98,
            child: IntrinsicHeight(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Stack(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 30,
                          ),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () => {Navigator.of(context).pop()},
                                child: const Icon(
                                  Icons.arrow_back_ios,
                                  size: 20,
                                  color: AlpacaColor.white100Color,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          right: -70,
                          top: -15,
                          height: MediaQuery.of(context).size.height * 0.45,
                          child: Transform.rotate(
                            angle: -45,
                            child: Image.asset(
                              'assets/onboarding/create-account-3D.png',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Padding(
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
                          style: theme.headline1,
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
                          children: <Widget>[
                            const Expanded(
                              child: Divider(
                                color: AlpacaColor.white100Color,
                                height: 40,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                'or'.tr(),
                                style: Theme.of(context).textTheme.bodyText2,
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
                        getSocialButton(
                          widget.isSignUp
                              ? 'onboarding.signUpWithGoogle'.tr()
                              : 'onboarding.signInWithGoogle'.tr(),
                          MediaQuery.of(context).size.width,
                          SvgPicture.asset(
                            'assets/google-logo.svg',
                          ),
                          () async {
                            await socialSignUp(context, appleLogin: false);
                          },
                        ),
                        getSocialButton(
                          widget.isSignUp
                              ? 'onboarding.signUpWithApple'.tr()
                              : 'onboarding.signInWithApple'.tr(),
                          MediaQuery.of(context).size.width,
                          SvgPicture.asset(
                            'assets/apple-logo.svg',
                          ),
                          () async {
                            await socialSignUp(context);
                          },
                          backgroundWhite: false,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                            top: 10,
                          ),
                          child: Text(
                            'onboarding.agreeToTerms'.tr(),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> socialSignUp(
    BuildContext context, {
    bool appleLogin = true,
  }) async {
    final User? user =
        await (appleLogin ? auth.signInWithApple() : auth.signInWithGoogle());
    if (user != null) {
      final prefs = await SharedPreferences.getInstance();

      final accountStatus = prefs.getInt(
        'ONBOARDING_STEP',
      );

      if (accountStatus == AccountStatus.onboarded.index) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(homeRoute, (route) => false);
      } else {
        Navigator.of(context).pushNamedAndRemoveUntil(
          onboardingCreateAccountRoute,
          (route) => false,
          arguments: CreateAccountData(
            phoneNumber: _textController.text,
            isSocialLogin: true,
          ),
        );
      }
    }
  }
}
