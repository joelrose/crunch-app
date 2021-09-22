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
  late Animation<double> heightSequence;
  late Animation<double> widthSequence;
  late Animation<double> borderRadiusSequence;

  Tween<double> scaleTween = Tween<double>(begin: 0, end: 1);

  double height = 0;
  double width = 0;

  @override
  void initState() {
    super.initState();

    // Defining controller with animation duration of two seconds
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));

    heightSequence = TweenSequence<double>(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0, end: 0.6)
              .chain(CurveTween(curve: Curves.ease)),
          weight: 50.0,
        ),
        TweenSequenceItem<double>(
          tween: ConstantTween<double>(0.6),
          weight: 20.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.6, end: 0.55)
              .chain(CurveTween(curve: Curves.ease)),
          weight: 10.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.55, end: 1)
              .chain(CurveTween(curve: Curves.ease)),
          weight: 20.0,
        ),
      ],
    ).animate(animationController);

    widthSequence = TweenSequence<double>(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0, end: 1)
              .chain(CurveTween(curve: Curves.ease)),
          weight: 20.0,
        ),
        TweenSequenceItem<double>(
          tween: ConstantTween<double>(1),
          weight: 80.0,
        ),
      ],
    ).animate(animationController);

    borderRadiusSequence = TweenSequence<double>(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0, end: 1)
              .chain(CurveTween(curve: Curves.ease)),
          weight: 50.0,
        ),
        TweenSequenceItem<double>(
          tween: ConstantTween<double>(1),
          weight: 30.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1, end: 0)
              .chain(CurveTween(curve: Curves.ease)),
          weight: 20.0,
        ),
      ],
    ).animate(animationController);

    animationController.addListener(() {
      setState(() {});
    });

    _loadWidget();

    animationController.forward();

    // Future.delayed(const Duration(seconds: 1)).then(
    //   (value) => setState(() {
    //     height = 1000;
    //     width = 500;
    //   }),
    // );
  }

  Future<Timer> _loadWidget() async {
    const _duration = Duration(seconds: 100);
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
              bottom: -40,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedBuilder(
                  builder: (BuildContext context, Widget? child) {
                    return Container(
                      height: size.height * 0.7,
                      width: widthSequence.value * (size.width * 2),
                      alignment: Alignment.bottomCenter,
                      decoration: const BoxDecoration(
                        color: AlpacaColor.primary100,
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            250,
                          ),
                        ),
                      ),
                    );
                  },
                  animation: animationController,
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
            // Positioned.fill(
            //   bottom: -MediaQuery.of(context).size.height,
            //   child: Align(
            //     alignment: Alignment.bottomCenter,
            //     child: Container(
            //       height: sizeSequence.value *
            //           2 *
            //           MediaQuery.of(context).size.height,
            //       width: 60,
            //       alignment: Alignment.bottomCenter,
            //       decoration: const BoxDecoration(
            //         color: AlpacaColor.blackColor,
            //         borderRadius: BorderRadius.all(
            //           Radius.circular(
            //             50,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
