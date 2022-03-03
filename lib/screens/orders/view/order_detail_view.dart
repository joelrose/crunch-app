import 'package:flutter/cupertino.dart';
import 'package:hermes_api/hermes_api.dart';

class OrderDetailView extends StatelessWidget {
  const OrderDetailView({Key? key, required this.order}) : super(key: key);

  static const route = 'orders/detail';
  final GetOrderResponseDto order;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(100),
      child: Column(
        children: [
          const Text('order detail'),
          Text(order.storeId.toString()),
          Text(order.price.toString()),
        ],
      ),
    );
  }
}
