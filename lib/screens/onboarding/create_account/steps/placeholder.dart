import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StepPlaceholder extends StatelessWidget {
  const StepPlaceholder({
    Key? key,
    required this.onFinish,
  }) : super(key: key);

  final void Function() onFinish;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(right: size.width * 0.2),
          child: Text(
            'You’re all set!',
            style: theme.headline1!.merge(
              const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
                color: AlpacaColor.blackColor,
                height: 1.4,
                letterSpacing: -0.24,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 40, top: 10),
          child: Text(
            '''We have sent you a verification email to your email address - please make sure to verify your email address within 24 hours. \n\nEnjoy crunch!''',
            style: theme.headline5,
          ),
        ),
        SvgPicture.asset(
          'assets/onboarding/placeholder.svg',
          height: 250,
        ),
        Expanded(
          child: Container(),
        ),
        ActionButton(
          buttonText: 'Start exploring',
          onPressed: onFinish,
        ),
      ],
    );
  }
}
