import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:pickup/screens/feedback/feedback.dart';

class HiddenWidget extends StatelessWidget {
  const HiddenWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        await showFeedbackForm(context);
      },
      child: Stack(
        children: [
          IgnorePointer(
            child: child,
          ),
        ],
      ),
    );
  }
}
