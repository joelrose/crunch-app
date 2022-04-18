import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pickup/l10n/l10n.dart';
import 'package:pickup/screens/onboarding/welcome/welcome.dart';
import 'package:pickup/screens/profile/widgets/profile_tile.dart';
import 'package:pickup/services/auth_service.dart';
import 'package:pickup/services/service_locator.dart';

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
        children: [
          Stack(
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
          ),
          const SizedBox(
            height: 20,
          ),
          const AlpacaDivider(),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTiles(),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: ActionButton(
                    buttonText: context.l10n.logout,
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
