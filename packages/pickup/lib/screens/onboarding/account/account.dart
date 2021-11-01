import 'package:alpaca/global.dart';
import 'package:alpaca/routes.dart';
import 'package:alpaca/screens/onboarding/create/create_account.dart';
import 'package:alpaca/services/auth_service.dart';
import 'package:alpaca/services/database_service.dart';
import 'package:alpaca/services/service_locator.dart';
import 'package:alpaca/shared/buttons.dart';
import 'package:alpaca/shared/page_wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
                          widget.isSignUp ? 'Create account' : 'Welcome back!',
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
                                ? 'Let’s get started by choosing one of the ways to sign up below.'
                                : 'Please enter you phone number to log in again!',
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
                                'or',
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
                              ? 'Sign up with Google'
                              : 'Sign in with Google',
                          'assets/google-logo.svg',
                          MediaQuery.of(context).size.width,
                          () async {
                            await socialSignUp(context, appleLogin: false);
                          },
                        ),
                        getSocialButton(
                          widget.isSignUp
                              ? 'Sign up with Apple'
                              : 'Sign in with Apple',
                          'assets/apple-logo.svg',
                          MediaQuery.of(context).size.width,
                          () async {
                            await socialSignUp(context);
                          },
                          backgroundWhite: false,
                        ),
                        const Padding(
                          padding:
                              EdgeInsets.only(left: 20, right: 20, top: 10),
                          child: Text(
                            'By continuing, I agree to Crunch’s Terms of service and Privacy Policy.',
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
      final userExists =
          await locator<DatabaseService>().reportDocumentExists(user.uid);

      if (userExists) {
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
