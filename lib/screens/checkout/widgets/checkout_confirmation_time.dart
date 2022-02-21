import 'dart:async';

import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';

class CheckoutConfirmationTime extends StatefulWidget {
  const CheckoutConfirmationTime({Key? key, required this.pickupTime})
      : super(key: key);

  final DateTime pickupTime;

  @override
  _CheckoutConfirmationTimeState createState() =>
      _CheckoutConfirmationTimeState();
}

class _CheckoutConfirmationTimeState extends State<CheckoutConfirmationTime> {
  late DateTime pickupTime;
  late DateTime now;
  late int minutesToPickupOrder;
  @override
  void initState() {
    now = DateTime.now();
    pickupTime = widget.pickupTime;
    minutesToPickupOrder = pickupTime.difference(now).inMinutes;
    if (minutesToPickupOrder >= 0) {
      // Timer.periodic(const Duration(seconds: 1), (timer) {
      //   if (!mounted) return;
      //   setState(() {
      //     now = DateTime.now();
      //     minutesToPickupOrder = pickupTime.difference(now).inMinutes;
      //   });
      // });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String waitTimeText = '';
    if (minutesToPickupOrder > 0) {
      waitTimeText = '${minutesToPickupOrder.toString()} min';
    } else {
      waitTimeText = 'Ready';
    }
    return Text(
      waitTimeText,
      style: Theme.of(context).textTheme.headline2?.copyWith(
            fontSize: 51,
            color: AlpacaColor.primary100,
            fontWeight: FontWeight.w600,
          ),
    );
  }
}
