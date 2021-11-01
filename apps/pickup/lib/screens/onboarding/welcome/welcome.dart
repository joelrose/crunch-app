
import 'package:alpaca/alpaca.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pickup/routes.dart';

class OnboardingWelcomeScreen extends StatefulWidget {
  const OnboardingWelcomeScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingWelcomeScreen> createState() =>
      _OnboardingWelcomeScreenState();
}

class _OnboardingWelcomeScreenState extends State<OnboardingWelcomeScreen> {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  // Future initialize() async {
  //   if (Platform.isIOS) {
  //     firebaseMessaging.requestPermission();

  //         firebaseMessaging.requestPermission((
  //       const IosNotificationSettings(sound: true, badge: true, alert: true));
  //   _firebaseMessaging.onIosSettingsRegistered
  //       .listen((IosNotificationSettings settings) {
  //     print("Settings registered: $settings");
  //   });
  //   _firebaseMessaging.getToken().then((String token) {
  //     assert(token != null);
  //     setState(() {
  //       _homeScreenText = "Push Messaging token: $token";
  //     });
  //     print(_homeScreenText);
  //   });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    // initialize();
    return PageWrapper(
      padding: EdgeInsets.zero,
      backgroundColor: AlpacaColor.primary100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'assets/onboarding/splash-graphic.png',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.5,
            fit: BoxFit.scaleDown,
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
                  'get_started.welcome'.tr(),
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
                  buttonText: 'getStarted'.tr(),
                  onPressed: () => {
                    Navigator.of(context).pushNamed(
                      onboardingExplanationRoute,
                    ),
                  },
                  isPrimaryButton: false,
                ),
                ActionButton(
                  buttonText: 'iAlreadyHaveAnAccount'.tr(),
                  onPressed: () => {
                    Navigator.of(context).pushNamed(
                      onboardingAccountRoute,
                      arguments: false,
                    ),
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
