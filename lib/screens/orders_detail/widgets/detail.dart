import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:hermes_repository/hermes_repository.dart';
import 'package:intl/intl.dart';
import 'package:pickup/shared/shared.dart';

class Detail extends StatelessWidget {
  const Detail({Key? key, required this.order}) : super(key: key);

  final GetOrdersResponse order;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              Text(
                DateFormat('dd.MM.yyyy, kk:mm').format(
                  DateTime.parse(order.estimatedPickupTime!).toLocal(),
                ),
              ),
              Text(
                ' - ${order.status}',
              ),
            ],
          ),
          Text(
            Utilities.currencyFormat(order.price!),
            style: Theme.of(context).textTheme.headline3!.copyWith(
                  color: AlpacaColor.primary100,
                ),
          ),
        ],
      ),
    );
  }
}
