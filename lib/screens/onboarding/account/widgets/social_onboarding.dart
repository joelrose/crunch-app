import 'package:alpaca/alpaca.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pickup/screens/home/home.dart';
import 'package:pickup/screens/onboarding/create_account/create_account.dart';
import 'package:pickup/services/auth_service.dart';
import 'package:pickup/services/hermes_service.dart';
import 'package:pickup/services/service_locator.dart';
import 'package:pickup/shared/models/create_account_model.dart';
import 'package:pickup/shared/show_async_loading.dart';

class SocialOnboarding extends StatelessWidget {
  SocialOnboarding({Key? key, required this.isSignUp}) : super(key: key);

  final bool isSignUp;
  final AuthService auth = locator<AuthService>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        getSocialButton(
          isSignUp
              ? 'onboarding.signUpWithGoogle'.tr()
              : 'onboarding.signInWithGoogle'.tr(),
          MediaQuery.of(context).size.width,
          SvgPicture.asset(
            'assets/google-logo.svg',
          ),
          () async {
            showAsyncLoading(
              context,
              _socialSignUp(context, appleLogin: false),
            );
          },
        ),
        getSocialButton(
          isSignUp
              ? 'onboarding.signUpWithApple'.tr()
              : 'onboarding.signInWithApple'.tr(),
          MediaQuery.of(context).size.width,
          SvgPicture.asset(
            'assets/apple-logo.svg',
          ),
          () async {
            showAsyncLoading(
              context,
              _socialSignUp(context),
            );
          },
          backgroundWhite: false,
        ),
      ],
    );
  }

  Future<void> _socialSignUp(
    BuildContext context, {
    bool appleLogin = true,
  }) async {
    final User? user =
        await (appleLogin ? auth.signInWithApple() : auth.signInWithGoogle());
    if (user != null) {
      // TODO: loading screen
      final hermesService = locator<HermesService>();

      final account = await hermesService.client.apiUsersGet();

      if (account.statusCode == 200) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          HomePage.route,
          (route) => false,
        );
      } else {
        Navigator.of(context).pushNamedAndRemoveUntil(
          OnboardingCreateAccountScreen.route,
          (route) => false,
          arguments: CreateAccountData(
            isSocialLogin: true,
          ),
        );
      }
    }
  }
}
