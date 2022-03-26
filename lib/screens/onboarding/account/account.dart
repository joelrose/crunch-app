import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:pickup/screens/onboarding/account/widgets/onboarding_login_fields.dart';

class OnboardingAccountScreen extends StatelessWidget {
  OnboardingAccountScreen({Key? key, required this.isSignUp}) : super(key: key);

  static const route = '/onboarding/account';

  final bool isSignUp;
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      padding: EdgeInsets.zero,
      backgroundColor: AlpacaColor.primary100,
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          _scrollController.jumpTo(0);
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const ClampingScrollPhysics(
            parent: NeverScrollableScrollPhysics(),
          ),
          child: SizedBox(
            height: (MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top) *
                0.98,
            child: _buildStack(context),
          ),
        ),
      ),
    );
  }

  Widget _buildStack(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            _buildHeader(context),
            const Spacer(),
            OnboardingLoginFields(isSignUp: isSignUp),
          ],
        ),
        _buildPositionedImage(context),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 30,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: AlpacaColor.white100Color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPositionedImage(BuildContext context) {
    return Positioned(
      right: -70,
      top: -15,
      height: MediaQuery.of(context).size.height * 0.55,
      child: Transform.rotate(
        angle: -45,
        child: Image.asset(
          'assets/onboarding/create-account-3D.png',
        ),
      ),
    );
  }
}
