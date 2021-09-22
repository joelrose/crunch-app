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

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  AuthService auth = locator<AuthService>();

  late AnimationController animationController;
  late Animation<double> tween;

  double height = 0;
  double width = 0;

  @override
  void initState() {
    super.initState();

    // Defining controller with animation duration of two seconds
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    tween = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeIn));
    animationController.addListener(() {
      setState(() {});
    });

    _loadWidget();

    // Future.delayed(const Duration(seconds: 1)).then(
    //   (value) => setState(() {
    //     height = 1000;
    //     width = 500;
    //   }),
    // );
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
          Navigator.of(context).pushNamedAndRemoveUntil(
            onboardingWelcomeRoute,
            (route) => false,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedContainer(
                  alignment: Alignment.bottomCenter,
                  decoration: const BoxDecoration(
                    color: AlpacaColor.primary100,
                    // borderRadius: BorderRadius.vertical(
                    //   top: Radius.circular(100),
                    // ),
                  ),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  duration: const Duration(milliseconds: 200),
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                child: SvgPicture.asset(
                  'assets/logo/crunch-logo.svg',
                  color: AlpacaColor.white100Color,
                  width: MediaQuery.of(context).size.width * 0.8,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
