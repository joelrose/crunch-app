import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';

class StoreTag extends StatelessWidget {
  const StoreTag({Key? key, required this.name}) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AlpacaColor.primary20,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: AlpacaColor.primary80,
                ),
          ),
        ],
      ),
    );
  }
}
