import 'package:alpaca/alpaca.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesignal_repository/onesignal_repository.dart';
import 'package:pickup/l10n/l10n.dart';
import 'package:pickup/screens/onboarding_welcome/onboarding_welcome.dart';
import 'package:pickup/screens/profile/cubit/profile_cubit.dart';
import 'package:pickup/screens/profile/widgets/profile_tile.dart';

class ProfilePage extends StatelessWidget {
  static const route = '/profile';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(
        authenticationRepository: context.read<AuthenticationRepository>(),
        oneSignalRepository: context.read<OneSignalRepository>(),
      ),
      child: const ProfileView(),
    );
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      padding: const EdgeInsets.symmetric(vertical: 30),
      backgroundColor: AlpacaColor.white100Color,
      statusBarStyle: SystemUiOverlayStyle.dark,
      child: Column(
        children: const [
          _Header(),
          SizedBox(
            height: 20,
          ),
          AlpacaDivider(),
          _SignOut(),
        ],
      ),
    );
  }
}

class _SignOut extends StatelessWidget {
  const _SignOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state.status == ProfileStatus.loggedOut) {
          Navigator.of(context).pushAndRemoveUntil(
            OnboardingWelcomePage.route(),
            (route) => false,
          );
        }
      },
      child: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const _Tiles(),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 18.0),
              child: ActionButton(
                key: const Key('logout_button'),
                buttonText: context.l10n.logout,
                isPrimaryButton: false,
                textColor: AlpacaColor.redColor,
                onPressed: () => context.read<ProfileCubit>().logoutUser(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Center(
          child: Text(
            'Profile',
            style: Theme.of(context).textTheme.headline1!.merge(
                  const TextStyle(
                    color: AlpacaColor.blackColor,
                  ),
                ),
          ),
        ),
        Positioned(
          left: 20,
          child: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            color: AlpacaColor.blackColor,
            icon: const Icon(
              Icons.arrow_back_ios,
            ),
            padding: const EdgeInsets.all(10),
          ),
        )
      ],
    );
  }
}

class _Tiles extends StatelessWidget {
  const _Tiles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 20,
        ),
        const ProfileTile(
          title: 'Language',
          link: 'https://crunch-app.notion.site/Imprint-e6703f9d44be4d0f9ee0992953056d74',
        ),
        const ProfileTile(
          title: 'Terms & Conditions',
          link: 'https://crunch-app.notion.site/Imprint-e6703f9d44be4d0f9ee0992953056d74',
        ),
        const ProfileTile(
          title: 'Data Privacy',
          link: 'https://crunch-app.notion.site/Imprint-e6703f9d44be4d0f9ee0992953056d74',
        ),
        const ProfileTile(
          title: 'Contact Us',
          link: 'mailto:joel@getcrunch.tech',
        ),
        const ProfileTile(
          title: 'Visit our Website',
          link: 'https://getcrunch.tech',
        ),
        const AlpacaDivider(),
      ],
    );
  }
}
