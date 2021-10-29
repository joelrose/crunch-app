import 'dart:async';
import 'package:alpaca/global.dart';
import 'package:flutter/material.dart';

class CheckoutConfirmationTime extends StatefulWidget {
  CheckoutConfirmationTime({Key? key, required this.pickupTime})
      : super(key: key);

  final DateTime pickupTime;

  @override
  _CheckoutConfirmationTimeState createState() =>
      _CheckoutConfirmationTimeState();
}

class _CheckoutConfirmationTimeState extends State<CheckoutConfirmationTime> {
  @override
  void initState() {
    Timer.periodic(const Duration(minutes: 1), (timer) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pickupTime = widget.pickupTime;
    final now = DateTime.now();
    final minutesToPickupOrder = pickupTime.difference(now).inMinutes;
    double fullScreenWidth = MediaQuery.of(context).size.width;
    String waitTimeText = '';
    if (minutesToPickupOrder > 0) {
      waitTimeText = '${minutesToPickupOrder.toString()} min';
    } else {
      waitTimeText = 'Ready';
    }
    return Text(
      '${minutesToPickupOrder} min',
      style: Theme.of(context).textTheme.headline2?.copyWith(
            fontSize: 51,
            color: AlpacaColor.primary100,
            fontWeight: FontWeight.w600,
          ),
    );
  }
}
