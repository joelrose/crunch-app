import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pickup/screens/onboarding/welcome/welcome.dart';
import 'package:pickup/screens/profile/widgets/profile_tile.dart';
import 'package:pickup/services/auth_service.dart';
import 'package:pickup/services/service_locator.dart';
import 'package:pickup/shared/alpaca_divider.dart';

class ProfileScreen extends StatelessWidget {
  static const route = '/profile';
  final AuthService auth = locator<AuthService>();

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      padding: const EdgeInsets.symmetric(vertical: 30),
      backgroundColor: AlpacaColor.white100Color,
      statusBarStyle: SystemUiOverlayStyle.dark,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTiles(),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 18.0),
            child: ActionButton(
              buttonText: 'Logout',
              isPrimaryButton: false,
              textColor: AlpacaColor.redColor,
              onPressed: () async {
                await auth.signOut();

                Navigator.of(context).pushNamedAndRemoveUntil(
                  OnboardingWelcomeScreen.route,
                  (route) => false,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTiles() {
    return Column(
      children: [
        Container(
          height: 20,
        ),
        const ProfileTile(
          title: 'Terms & Conditions',
          icon: Icons.person_outlined,
          link: '',
        ),
        const ProfileTile(
          title: 'Data Privacy',
          icon: Icons.person_outlined,
          link: '',
        ),
        const ProfileTile(
          title: 'Contact Us',
          icon: Icons.person_outlined,
          link: '',
        ),
        const ProfileTile(
          title: 'Visit our Website',
          icon: Icons.settings,
          link: '',
        ),
        const AlpacaDivider(),
      ],
    );
  }
}
