import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';

class OrdersLoadingView extends StatelessWidget {
  const OrdersLoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Center(
        child: SizedBox(
          height: 50,
          width: 50,
          child: CircularProgressIndicator(
            color: AlpacaColor.primary100,
          ),
        ),
      ),
    );
  }
}
