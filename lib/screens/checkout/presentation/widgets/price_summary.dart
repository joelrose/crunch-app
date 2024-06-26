import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickup/l10n/l10n.dart';
import 'package:pickup/screens/app/app.dart';
import 'package:pickup/shared/price_calculation.dart';
import 'package:pickup/shared/utilities.dart';

class PriceSummary extends StatelessWidget {
  const PriceSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final checkoutItems =
        context.select((CheckoutBasketBloc cubit) => cubit.state.checkoutItems);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: AlpacaColor.lightGreyColor90),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  context.l10n.orderSummary,
                  style: Theme.of(context).textTheme.headline3?.copyWith(
                        color: AlpacaColor.darkNavyColor,
                      ),
                ),
              ),
            ),
            _ItemSummary(
              labelText: context.l10n.subtotal,
              price: Utilities.currencyFormat(
                PriceCalulcation.getPriceOfItems(checkoutItems),
              ),
            ),
            /*_ItemSummary(
              labelText: context.l10n.discount,
              price: Utilities.currencyFormat(
                0.0,
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}

class _ItemSummary extends StatelessWidget {
  const _ItemSummary({
    Key? key,
    required this.labelText,
    required this.price,
  }) : super(key: key);

  final String labelText;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 0, 14, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            labelText,
            style: const TextStyle(
              color: AlpacaColor.darkGreyColor,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
          Text(
            price,
            style: const TextStyle(
              color: AlpacaColor.blackColor,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
