import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pickup/global.dart';
import 'package:pickup/routes.dart';
import 'package:pickup/services/auth_service.dart';
import 'package:pickup/services/service_locator.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  AuthService auth = locator<AuthService>();

  late AnimationController animationController;
  late Animation<double> heightSequence;
  late Animation<double> widthSequence;

  bool isLogoVisible = true;

  @override
  void initState() {
    super.initState();

    // Defining controller with animation duration of two seconds
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    heightSequence = TweenSequence<double>(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0, end: 0.9)
              .chain(CurveTween(curve: Curves.ease)),
          weight: 50.0,
        ),
        TweenSequenceItem<double>(
          tween: ConstantTween<double>(0.9),
          weight: 20.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.9, end: 0.85)
              .chain(CurveTween(curve: Curves.ease)),
          weight: 10.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.85, end: 2)
              .chain(CurveTween(curve: Curves.ease)),
          weight: 20.0,
        ),
      ],
    ).animate(animationController);

    widthSequence = TweenSequence<double>(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0, end: 4)
              .chain(CurveTween(curve: Curves.ease)),
          weight: 20.0,
        ),
        TweenSequenceItem<double>(
          tween: ConstantTween<double>(4),
          weight: 80.0,
        ),
      ],
    ).animate(animationController);

    animationController.addListener(() {
      if (isLogoVisible && heightSequence.value > 1) {
        setState(() {
          isLogoVisible = false;
        });
      }
    });

    animationController.forward();

    _loadWidget();
  }

  Future<Timer> _loadWidget() async {
    const _duration = Duration(milliseconds: 1600);
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
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              left: -size.height,
              right: -size.height,
              bottom: -(size.width / 2),
              top: -100,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedBuilder(
                  builder: (BuildContext context, Widget? child) {
                    return Container(
                      height: heightSequence.value * size.height,
                      width: widthSequence.value * size.width,
                      alignment: Alignment.bottomCenter,
                      decoration: const BoxDecoration(
                        color: AlpacaColor.primary100,
                        shape: BoxShape.circle,
                      ),
                    );
                  },
                  animation: animationController,
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                child: AnimatedOpacity(
                  opacity: isLogoVisible ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: SvgPicture.asset(
                    'assets/logo/crunch-logo.svg',
                    color: AlpacaColor.white100Color,
                    width: MediaQuery.of(context).size.width * 0.65,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
