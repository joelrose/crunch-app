import 'package:alpaca/global.dart';
import 'package:alpaca/routes.dart';
import 'package:alpaca/screens/onboarding/explanation/widgets/slide_widget.dart';
import 'package:alpaca/shared/buttons.dart';
import 'package:alpaca/shared/page_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingExplanationScreen extends StatefulWidget {
  OnboardingExplanationScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingExplanationScreen> createState() =>
      _OnboardingExplanationScreenState();
}

class _OnboardingExplanationScreenState
    extends State<OnboardingExplanationScreen> {
  final PageController _controller = PageController();

  int _currentPage = 0;

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
  void initState() {
    super.initState();
    _currentPage = 0;
    _controller.addListener(() {
      setState(() {
        _currentPage = _controller.page!.toInt();
      });
    });
  }

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
            height: MediaQuery.of(context).size.height * 0.7,
            child: PageView.builder(
              itemCount: _pages.length,
              controller: _controller,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return _pages[index % _pages.length];
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(
                _pages.length,
                (index) => Container(
                  width: 10,
                  height: 10,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: index == _currentPage
                        ? AlpacaColor.white100Color
                        : AlpacaColor.darkGreyColor,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, i) {
                return Container(
                  color: i % 2 == 0
                      ? AlpacaColor.redColor
                      : AlpacaColor.primary100,
                  height: 10,
                  width: 10,
                  margin: const EdgeInsets.all(30),
                  padding: const EdgeInsets.all(30),
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
