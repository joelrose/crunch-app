import 'package:alpaca/alpaca.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickup/l10n/l10n.dart';
import 'package:pickup/screens/onboarding_welcome/onboarding_welcome.dart';
import 'package:pickup/screens/profile/widgets/profile_tile.dart';

class ProfilePage extends StatelessWidget {
  static const route = '/profile';

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
    return Expanded(
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
              onPressed: () async {
                final authenticationRepository =
                    context.read<AuthenticationRepository>();

                await authenticationRepository.signOut();

                Navigator.of(context).pushAndRemoveUntil(
                  OnboardingWelcomePage.route(),
                  (route) => false,
                );
              },
            ),
          ),
        ],
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
          link: '',
        ),
        const ProfileTile(
          title: 'Terms & Conditions',
          link: '',
        ),
        const ProfileTile(
          title: 'Data Privacy',
          link: '',
        ),
        const ProfileTile(
          title: 'Contact Us',
          link: '',
        ),
        const ProfileTile(
          title: 'Visit our Website',
          link: '',
        ),
        const AlpacaDivider(),
      ],
    );
  }
}
