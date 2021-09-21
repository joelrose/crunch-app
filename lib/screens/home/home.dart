import 'package:alpaca/global.dart';
import 'package:alpaca/routes.dart';
import 'package:alpaca/services/auth_service.dart';
import 'package:alpaca/services/service_locator.dart';
import 'package:alpaca/shared/buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      backgroundColor: AlpacaColor.primary100,
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
              child: Text('Authenticated!'),
            ),
            ActionButton(
              buttonText: 'Logout',
              onPressed: () async {
                await auth.signOut();
                Navigator.of(context).pushNamedAndRemoveUntil(
                  startRoute,
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AlpacaColor.primary100,
        unselectedItemColor: AlpacaColor.greyColor,
        showUnselectedLabels: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.compass_calibration),
            label: 'Discover',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: 'Vouchers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
        ],
      ),
    );
  }
}
