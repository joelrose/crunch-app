import 'package:alpaca/global.dart';
import 'package:alpaca/routes.dart';
import 'package:alpaca/screens/profile/profile_pages/get_support/get_support.dart';
import 'package:alpaca/screens/profile/profile_pages/placeholder.dart';
import 'package:alpaca/services/auth_service.dart';
import 'package:alpaca/services/service_locator.dart';
import 'package:alpaca/shared/buttons.dart';
import 'package:alpaca/shared/page_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
        const Divider(),
        TextButton(
          style: TextButton.styleFrom(padding: EdgeInsets.zero),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => link),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      icon,
                      size: 30,
                      color: AlpacaColor.darkGreyColor,
                    ),
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
                height: 85,
                width: 85,
                margin: const EdgeInsets.only(bottom: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: AlpacaColor.primary100, width: 3),
                ),
              ),
              const ProfileTile(
                title: 'My orders',
                icon: Icons.menu,
                link: PlaceholderSide(),
              ),
              const Divider(),
              Container(
                height: 20,
              ),
              const ProfileTile(
                title: 'My details',
                icon: Icons.person_outlined,
                link: PlaceholderSide(),
              ),
              const ProfileTile(
                title: 'Payment methods',
                icon: Icons.credit_card,
                link: PlaceholderSide(),
              ),
              const ProfileTile(
                title: 'Preferences',
                icon: Icons.settings,
                link: PlaceholderSide(),
              ),
              const Divider(),
              Container(
                height: 20,
              ),
              const ProfileTile(
                title: 'Get support',
                icon: Icons.help_outline,
                link: GetSupport(),
              ),
              const Divider(),
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
                Navigator.of(context).pushNamedAndRemoveUntil(
                  onboardingWelcomeRoute,
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