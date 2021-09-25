import 'dart:math';

import 'package:alpaca/global.dart';
import 'package:alpaca/routes.dart';
import 'package:alpaca/screens/onboarding/explanation/widgets/dots_indicator.dart';
import 'package:alpaca/screens/onboarding/explanation/widgets/slide_widget.dart';
import 'package:alpaca/shared/buttons.dart';
import 'package:alpaca/shared/page_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnboardingExplanationScreen extends StatefulWidget {
  const OnboardingExplanationScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingExplanationScreen> createState() =>
      _OnboardingExplanationScreenState();
}

class _OnboardingExplanationScreenState
    extends State<OnboardingExplanationScreen> {
  final PageController _controller = PageController();

  final List<Widget> _pages = const <Widget>[
    SlideWidget(
      title: 'Takeout reinvented',
      description:
          'With Crunch you can order pickup cooler than ever. And faster.',
      image: 'assets/onboarding/step-1.png',
    ),
    SlideWidget(
      title: 'Personalized for you',
      description:
          'Discover new places, collect stamps and benefit from special discounts from your favourite stores.',
      image: 'assets/onboarding/step-2.png',
    ),
    SlideWidget(
      title: 'Food goes social',
      description:
          'See where others are eating, send gifts to your friends and enjoy food together.',
      image: 'assets/onboarding/step-3.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      backgroundColor: AlpacaColor.primary100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => {Navigator.of(context).pop()},
                      child: const Icon(
                        Icons.arrow_back_ios,
                        size: 20,
                        color: AlpacaColor.white100Color,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.65,
            child: PageView.builder(
              itemCount: _pages.length,
              controller: _controller,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return _pages[index % _pages.length];
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: DotsIndicator(
              controller: _controller,
              itemCount: _pages.length,
              normalColor: Theme.of(context).scaffoldBackgroundColor,
              onPageSelected: (int page) {
                _controller.animateToPage(
                  page,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
              },
            ),
          ),
          ActionButton(
            buttonText: 'Continue',
            onPressed: () => {
              Navigator.of(context)
                  .pushNamed(onboardingAccountRoute, arguments: true)
            },
            isPrimaryButton: false,
          ),
        ],
      ),
    );
  }
}
