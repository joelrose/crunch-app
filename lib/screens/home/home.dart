import 'package:alpaca/global.dart';
import 'package:alpaca/routes.dart';
import 'package:alpaca/screens/home/widgets/home_main.dart';
import 'package:alpaca/services/auth_service.dart';
import 'package:alpaca/services/service_locator.dart';
import 'package:alpaca/shared/buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthService auth = locator<AuthService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AlpacaColor.white100Color,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
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
              const HomeMain(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AlpacaColor.primary100,
        unselectedItemColor: AlpacaColor.greyColor,
        showUnselectedLabels: true,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/compass.svg'),
            label: 'Discover',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/voucher.svg',),
            label: 'Vouchers',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/star.svg'),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/search.svg'),
            label: 'Search',
          ),
        ],
      ),
    );
  }
}
