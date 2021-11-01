import 'package:flutter/material.dart';
import 'package:pickup/global.dart';
import 'package:pickup/shared/buttons.dart';

class StepPlaceholder extends StatefulWidget {
  const StepPlaceholder(
      {Key? key, required this.onFinish,})
      : super(key: key);

  final void Function() onFinish;

  @override
  _StepPhoneVerificationState createState() => _StepPhoneVerificationState();
}

class _StepPhoneVerificationState extends State<StepPlaceholder> {

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
            "Placeholder",
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
            'Placeholder',
            style: theme.subtitle1!.merge(
              const TextStyle(
                color: AlpacaColor.blackColor,
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(),
        ),
        ActionButton(
          buttonText: 'Continue',
          onPressed: () {
            widget.onFinish();
          },
        ),
      ],
    );
  }
}
