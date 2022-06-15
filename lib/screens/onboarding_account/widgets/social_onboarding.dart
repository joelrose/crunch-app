// ignore_for_file: use_build_context_synchronously

import 'package:alpaca/alpaca.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hermes_repository/hermes_repository.dart';
import 'package:loading_overlay_repository/loading_overlay_repository.dart';
import 'package:pickup/l10n/l10n.dart';
import 'package:pickup/screens/home/home.dart';
import 'package:pickup/screens/onboarding_account/cubit/onboarding_account_cubit.dart';
import 'package:pickup/screens/onboarding_create_account/onboarding_create_account.dart';

class SocialOnboarding extends StatelessWidget {
  const SocialOnboarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSignUp =
        context.select((OnboardingAccountCubit cubit) => cubit.state.isSignUp);

    return Column(
      children: [
        getSocialButton(
          isSignUp
              ? context.l10n.signUpWithGoogle
              : context.l10n.signInWithGoogle,
          MediaQuery.of(context).size.width,
          SvgPicture.asset(
            'assets/google-logo.svg',
          ),
          () async {
            context.read<LoadingOverlayRepository>().asyncLoading(
                  _socialSignUp(context, appleLogin: false),
                );
          },
        ),
        FutureBuilder(
          future: context.read<AuthenticationRepository>().appleSignInAvailable,
          builder: (context, snapshot) {
            if (snapshot.data == true) {
              return getSocialButton(
                isSignUp
                    ? context.l10n.signUpWithApple
                    : context.l10n.signInWithApple,
                MediaQuery.of(context).size.width,
                SvgPicture.asset(
                  'assets/apple-logo.svg',
                ),
                () async {
                  context.read<LoadingOverlayRepository>().asyncLoading(
                        _socialSignUp(context),
                      );
                },
                backgroundWhite: false,
              );
            } else {
              return Container();
            }
          },
        ),
      ],
    );
  }

  Future<void> _socialSignUp(
    BuildContext context, {
    bool appleLogin = true,
  }) async {
    final authenticationRepository = context.read<AuthenticationRepository>();
    final user = await (appleLogin
        ? authenticationRepository.signInWithApple()
        : authenticationRepository.signInWithGoogle());

    if (user != null) {
      final hermesRepository = context.read<HermesRepository>();

      final response =
          await hermesRepository.client.apiWhitelistuserPost(body: user.email);

      if (response.isSuccessful && response.body == true) {
        final account = await hermesRepository.client.apiUsersGet();

        if (account.isSuccessful) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            HomePage.route,
            (route) => false,
          );
        } else {
          Navigator.of(context).pushAndRemoveUntil(
            OnboardingCreateAccountPage.route(
              data: const CreateAccountData(
                isSocialLogin: true,
              ),
            ),
            (route) => false,
          );
        }
      } else {
        final snackBar = SnackBar(
          content: Text(context.l10n.notOnWhitelist),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        await authenticationRepository.signOut();
      }
    }
  }
}
