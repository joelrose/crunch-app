import 'package:flutter/material.dart';
import 'package:pickup/screens/feedback/view/view.dart';

Future<void> showFeedbackForm(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      final query = MediaQuery.of(context);
      final height = query.size.height;

      final factor = (500 + query.viewPadding.bottom) / height;

      return FractionallySizedBox(
        heightFactor: factor,
        child: const FeedbackView(),
      );
    },
  );
}
