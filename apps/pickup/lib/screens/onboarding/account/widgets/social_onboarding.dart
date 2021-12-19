import 'package:alpaca/alpaca.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pickup/services/account_status.dart';
import 'package:pickup/services/auth_service.dart';
import 'package:pickup/services/service_locator.dart';
import 'package:pickup/shared/models.dart';
import 'package:pickup/shared/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SocialOnboarding extends StatefulWidget {
  const SocialOnboarding({Key? key, required this.isSignUp}) : super(key: key);

  final bool isSignUp;

  @override
  State<SocialOnboarding> createState() => _SocialOnboardingState();
}

class _SocialOnboardingState extends State<SocialOnboarding> {
  final AuthService auth = locator<AuthService>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
      ],
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
        if (mounted) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(homeRoute, (route) => false);
        }
      } else {
        if (mounted) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            onboardingCreateAccountRoute,
            (route) => false,
            arguments: CreateAccountData(
              isSocialLogin: true,
            ),
          );
        }
      }
    }
  }
}
