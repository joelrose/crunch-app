import 'package:alpaca/alpaca.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pickup/screens/onboarding/account/widgets/account_header.dart';
import 'package:pickup/screens/onboarding/account/widgets/onboarding_login_fields.dart';

class OnboardingAccountScreen extends StatefulWidget {
  const OnboardingAccountScreen({Key? key, required this.isSignUp})
      : super(key: key);

  static const route = '/onboarding/account';

  final bool isSignUp;

  @override
  State<OnboardingAccountScreen> createState() =>
      _OnboardingAccountScreenState();
}

class _OnboardingAccountScreenState extends State<OnboardingAccountScreen> {
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
            child: IntrinsicHeight(
              child: Column(
                children: [
                  const OnboardingAccountHeader(),
                  const Spacer(),
                  OnboardingLoginFields(isSignUp: widget.isSignUp),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
