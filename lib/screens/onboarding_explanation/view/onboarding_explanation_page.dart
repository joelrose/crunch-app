import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:pickup/l10n/l10n.dart';
import 'package:pickup/screens/onboarding/account/account.dart';
import 'package:pickup/screens/onboarding_explanation/widgets/widgets.dart';

class OnboardingExplanationPage extends StatelessWidget {
  const OnboardingExplanationPage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute(
      builder: (_) => const OnboardingExplanationPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const OnboardingExplanationView();
  }
}

class OnboardingExplanationView extends StatelessWidget {
  const OnboardingExplanationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              key: const Key('onboarding_explanation.back'),
              onTap: () => Navigator.of(context).pop(),
              child: const Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: AlpacaColor.white100Color,
              ),
            ),
          ),
          const _Slider(),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
            ),
            child: ActionButton(
              key: const Key('onboarding_explanation.next'),
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

class _Slider extends StatefulWidget {
  const _Slider({Key? key}) : super(key: key);

  @override
  State<_Slider> createState() => _SliderState();
}

class _SliderState extends State<_Slider> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

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
        image: 'assets/onboarding/step-2.png',
      ),
      SlideWidget(
        title: context.l10n.explanationTitle3,
        description: context.l10n.explanationDescription3,
        image: 'assets/onboarding/step-3.png',
      ),
    ];

    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.65,
          child: PageView.builder(
            itemCount: _pages.length,
            controller: _pageController,
            physics: const ClampingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return _pages[index % _pages.length];
            },
          ),
        ),
        DotsIndicator(
          controller: _pageController,
          itemCount: _pages.length,
          normalColor: Theme.of(context).scaffoldBackgroundColor,
          onPageSelected: (int page) => _pageController.animateToPage(
            page,
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          ),
        ),
      ],
    );
  }
}
