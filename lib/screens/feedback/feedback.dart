import 'package:flutter/material.dart';
import 'package:pickup/screens/feedback/view/view.dart';

Future<void> showFeedbackForm(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      final height = MediaQuery.of(context).size.height;
      final factor = 520 / height;

      return FractionallySizedBox(
        heightFactor: factor,
        child: const FeedbackView(),
      );
    },
  );
}
