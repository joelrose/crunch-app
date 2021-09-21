import 'dart:async';

import 'package:alpaca/global.dart';
import 'package:alpaca/routes.dart';
import 'package:alpaca/services/auth_service.dart';
import 'package:alpaca/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  AuthService auth = locator<AuthService>();

  @override
  void initState() {
    super.initState();

    _loadWidget();
  }

  Future<Timer> _loadWidget() async {
    const _duration = Duration(seconds: 5);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    auth.getUser.then(
      (user) {
        if (user != null) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(homeRoute, (route) => false);
        } else {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(onboardingWelcomeRoute, (route) => false);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AlpacaColor.primary100,
      body: Container(
        alignment: Alignment.center,
        child: SvgPicture.asset(
          'assets/logo/crunch-logo.svg',
          color: AlpacaColor.white100Color,
          width: MediaQuery.of(context).size.width * 0.8,
        ),
      ),
    );
  }
}
