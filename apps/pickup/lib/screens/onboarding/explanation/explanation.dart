import 'package:alpaca/alpaca.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pickup/screens/onboarding/explanation/widgets/dots_indicator.dart';
import 'package:pickup/screens/onboarding/explanation/widgets/slide_widget.dart';
import 'package:pickup/shared/routes.dart';

class OnboardingExplanationScreen extends StatelessWidget {
  final PageController _controller = PageController();

  final List<Widget> _pages = [
    for (int i = 1; i <= 3; i++)
      SlideWidget(
        title: 'onboarding_explanation.title_$i'.tr(),
        description: 'onboarding_explanation.description_$i'.tr(),
        image: 'assets/onboarding/step-$i.png',
      )
  ];

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      backgroundColor: AlpacaColor.primary100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(bottom: 10),
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: const Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: AlpacaColor.white100Color,
              ),
            ),
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
          Padding(
            padding: const EdgeInsets.all(20),
            child: DotsIndicator(
              controller: _controller,
              itemCount: _pages.length,
              normalColor: Theme.of(context).scaffoldBackgroundColor,
              onPageSelected: (int page) => _controller.animateToPage(
                page,
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
              ),
            ),
          ),
          ActionButton(
            buttonText: 'continue'.tr(),
            onPressed: () => Navigator.of(context)
                .pushNamed(onboardingAccountRoute, arguments: true),
            isPrimaryButton: false,
          ),
        ],
      ),
    );
  }
}
