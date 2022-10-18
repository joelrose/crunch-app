import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:hermes_repository/hermes_repository.dart';
import 'package:pickup/shared/shared.dart';

class ItemList extends StatelessWidget {
  const ItemList({Key? key, required this.items}) : super(key: key);

  final List<OrderItem> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      shrinkWrap: true,
      itemBuilder: (context, itemIndex) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 4,
          ),
          child: OrderItemWidget(
            item: items[itemIndex],
            isEditable: false,
          ),
        );
      },
    );
  }
}
