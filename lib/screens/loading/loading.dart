import 'package:alpaca/alpaca.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pickup/screens/home/home.dart';
import 'package:pickup/screens/onboarding_welcome/view/onboarding_welcome_page.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  static const route = '/';

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
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

    // listen to is animation finished

    animationController.addListener(() {
      if (!animationController.isAnimating) {
        navigationPage();
      }
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void navigationPage() {
    context.read<AuthenticationRepository>().getUser.then(
      (user) {
        if (user != null) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            HomePage.route,
            (route) => false,
          );
        } else {
          Navigator.of(context).pushAndRemoveUntil(
            OnboardingWelcomePage.route(),
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
                  duration: const Duration(seconds: 1),
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
