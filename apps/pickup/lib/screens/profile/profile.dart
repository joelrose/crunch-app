import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pickup/screens/onboarding/welcome/welcome.dart';
import 'package:pickup/screens/profile/profile_pages/placeholder.dart';
import 'package:pickup/services/auth_service.dart';
import 'package:pickup/services/service_locator.dart';
import 'package:pickup/shared/alpaca_divider.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    Key? key,
    required this.title,
    required this.icon,
    required this.link,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final Widget link;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AlpacaDivider(),
        TextButton(
          style: TextButton.styleFrom(padding: EdgeInsets.zero),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => link),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.bodyText1!.merge(
                              const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                      ),
                    ),
                  ],
                ),
                const Icon(
                  Icons.navigate_next,
                  size: 30,
                  color: AlpacaColor.darkGreyColor,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  static const route = '/profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  AuthService auth = locator<AuthService>();

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      padding: const EdgeInsets.symmetric(vertical: 30),
      backgroundColor: AlpacaColor.white100Color,
      statusBarStyle: SystemUiOverlayStyle.dark,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                height: 20,
              ),
              const ProfileTile(
                title: 'Terms & Conditions',
                icon: Icons.person_outlined,
                link: PlaceholderSide(),
              ),
              const ProfileTile(
                title: 'Data Privacy',
                icon: Icons.person_outlined,
                link: PlaceholderSide(),
              ),
              const ProfileTile(
                title: 'Contact Us',
                icon: Icons.person_outlined,
                link: PlaceholderSide(),
              ),
              const ProfileTile(
                title: 'Visit our Website',
                icon: Icons.settings,
                link: PlaceholderSide(),
              ),
              const AlpacaDivider(),
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 18.0),
            child: ActionButton(
              buttonText: 'Logout',
              isPrimaryButton: false,
              textColor: AlpacaColor.redColor,
              onPressed: () async {
                await auth.signOut();

                if (mounted) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    OnboardingWelcomeScreen.route,
                    (route) => false,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
