import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';

class ProductBasicDetails extends StatelessWidget {
  const ProductBasicDetails({
    Key? key,
    required this.title,
    required this.itemPrice,
  }) : super(key: key);
  final String title;
  final num itemPrice;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .merge(const TextStyle(fontSize: 22)),
              ),
              Text(
                '${itemPrice.toStringAsFixed(2)} €',
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: AlpacaColor.primary100,
                    ),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'Example description! Should be changed when basic details are available',
            style: Theme.of(context).textTheme.headline5,
          )
        ],
      ),
    );
  }
}
