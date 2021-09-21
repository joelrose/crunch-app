import 'package:alpaca/global.dart';
import 'package:alpaca/screens/onboarding/onboarding_wrapper.dart';
import 'package:alpaca/services/auth_service.dart';
import 'package:alpaca/services/service_locator.dart';
import 'package:alpaca/shared/buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final AuthService auth = locator<AuthService>();

  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return OnboardingPageWrapper(
      padding: EdgeInsets.zero,
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Create account',
                  style: theme.headline1,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 30,
                    top: 10,
                    right: 40,
                  ),
                  child: Text(
                    'Let’s get started by choosing one of the ways to sign up below.',
                    style: theme.subtitle1,
                  ),
                ),
                TextField(
                  controller: _textController,
                  textInputAction: TextInputAction.send,
                  keyboardType: TextInputType.phone,
                  autocorrect: false,
                  cursorColor: AlpacaColor.white100Color,
                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: () async {
                        final bool loggedIn = await auth.verifyNumber(
                          _textController.text,
                        );

                        print(loggedIn);
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
                    hintStyle: const TextStyle(color: AlpacaColor.white80Color),
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
                      padding: const EdgeInsets.symmetric(horizontal: 20),
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
                  'Sign up with Google',
                  'assets/google-logo.svg',
                  MediaQuery.of(context).size.width,
                  () async {
                    final User? user = await auth.signInWithGoogle();
                    debugPrint(user?.email);
                  },
                ),
                getSocialButton(
                  'Sign up with Apple',
                  'assets/apple-logo.svg',
                  MediaQuery.of(context).size.width,
                  () async {
                    final User? user = await auth.signInWithApple();
                    debugPrint(user?.email);
                  },
                  backgroundWhite: false,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: Text(
                    'By continuing, I agree to Crunch’s Terms of service and Privacy Policy.',
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
          Positioned(
            right: -75,
            top: -25,
            height: 375,
            child: Transform.rotate(
              angle: -45,
              child: Image.asset('assets/onboarding/create-account-3D.png'),
            ),
          ),
        ],
      ),
    );
  }
}
