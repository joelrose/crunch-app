import 'dart:async';

import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickup/l10n/l10n.dart';

import '../../cubits/cubit.dart';

class CheckoutConfirmationTime extends StatefulWidget {
  const CheckoutConfirmationTime({Key? key})
      : super(key: key);

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
    
    pickupTime = context.read<CheckoutTimeCubit>().state.pickupTime;

    minutesToPickupOrder = pickupTime.difference(now).inMinutes;
    if (minutesToPickupOrder >= 0) {
      Timer.periodic(const Duration(seconds: 1), (timer) {
        if (!mounted) return;
        setState(() {
          now = DateTime.now();
          minutesToPickupOrder = pickupTime.difference(now).inMinutes;
        });
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String waitTimeText = '';
    if (minutesToPickupOrder > 0) {
      waitTimeText = '${minutesToPickupOrder.toString()} ${context.l10n.min}';
    } else {
      waitTimeText = context.l10n.ready;
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
