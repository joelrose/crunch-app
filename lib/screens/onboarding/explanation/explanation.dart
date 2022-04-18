import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:pickup/l10n/l10n.dart';
import 'package:pickup/screens/onboarding/account/account.dart';
import 'package:pickup/screens/onboarding/explanation/widgets/dots_indicator.dart';
import 'package:pickup/screens/onboarding/explanation/widgets/slide_widget.dart';

class OnboardingExplanationScreen extends StatelessWidget {
  static const route = '/onboarding/explanation';

  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      SlideWidget(
        title: context.l10n.explanationTitle1,
        description: context.l10n.explanationDescription1,
        image: 'assets/onboarding/step-1.png',
      ),
      SlideWidget(
        title: context.l10n.explanationTitle2,
        description: context.l10n.explanationDescription2,
        image: 'assets/onboarding/step-1.png',
      ),
      SlideWidget(
        title: context.l10n.explanationTitle3,
        description: context.l10n.explanationDescription3,
        image: 'assets/onboarding/step-1.png',
      ),
    ];

    return PageWrapper(
      padding: EdgeInsets.zero,
      backgroundColor: AlpacaColor.primary100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.fromLTRB(18, 30, 18, 0),
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
          DotsIndicator(
            controller: _controller,
            itemCount: _pages.length,
            normalColor: Theme.of(context).scaffoldBackgroundColor,
            onPageSelected: (int page) => _controller.animateToPage(
              page,
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
            ),
            child: ActionButton(
              buttonText: context.l10n.next,
              onPressed: () => Navigator.of(context).pushNamed(
                OnboardingAccountScreen.route,
                arguments: true,
              ),
              isPrimaryButton: false,
            ),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
