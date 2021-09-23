import 'package:alpaca/global.dart';
import 'package:alpaca/routes.dart';
import 'package:alpaca/services/auth_service.dart';
import 'package:alpaca/services/service_locator.dart';
import 'package:alpaca/shared/buttons.dart';
import 'package:flutter/material.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  AuthService auth = locator<AuthService>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          child: Text(
            'Favorites',
            style: Theme.of(context).textTheme.headline1!.merge(
                  const TextStyle(
                    color: AlpacaColor.blackColor,
                  ),
                ),
          ),
        ),
        const Divider(),
        const Expanded(
          child: Center(
              child: Text(
                  'Hey, unfortunately we are still building this feature 😟')),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 18.0),
          child: ActionButton(
            buttonText: 'Logout',
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
    );
  }
}
