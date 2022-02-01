import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:pickup/screens/checkout/widgets/checkout_main_widget.dart';
import 'package:pickup/screens/checkout/widgets/divider_widget.dart';
import 'package:pickup/shared/utilities.dart';
import 'package:sanity/sanity.dart';

class CheckoutItemAmount {
  CheckoutItemAmount({
    required this.id,
    required this.title,
    required this.amount,
    required this.totalPrice,
  });
  String id;
  LocaleString title;
  int amount;
  double totalPrice;
}

class CheckoutCartItemsWidget extends StatelessWidget {
  const CheckoutCartItemsWidget({Key? key, required this.checkoutItems})
      : super(key: key);

  final List<CheckoutItemModel> checkoutItems;

  @override
  Widget build(BuildContext context) {
    final List<CheckoutItemAmount> checkoutSummaryList = [];
    for (var itemIndex = 0; itemIndex < checkoutItems.length; itemIndex++) {
      final item = checkoutItems[itemIndex];
      int itemAmount = 0;
      for (final checkoutItem in checkoutItems) {
        if (checkoutItem.id == item.id) {
          itemAmount++;
        }
      }
      final double checkoutItemPrice = item.price.toDouble();
      double itemAddOnPrice = 0;
      for (final itemOption in item.itemOptions) {
        itemAddOnPrice += itemOption.option.price;
      }

      final double itemTotalPrice = checkoutItemPrice + itemAddOnPrice;
      if (checkoutSummaryList.isNotEmpty) {
        bool isInList = false;
        for (var i = 0; i < checkoutSummaryList.length; i++) {
          final checkoutItem = checkoutSummaryList[i];
          if (checkoutItem.id == item.id) {
            isInList = true;
            break;
          }
        }
        if (!isInList) {
          checkoutSummaryList.add(
            CheckoutItemAmount(
              id: item.id,
              title: item.title,
              amount: itemAmount,
              totalPrice: itemTotalPrice * itemAmount,
            ),
          );
        }
      } else {
        checkoutSummaryList.add(
          CheckoutItemAmount(
            id: item.id,
            title: item.title,
            amount: itemAmount,
            totalPrice: itemTotalPrice * itemAmount,
          ),
        );
      }
    }
    return Column(
      children: [
        CheckoutHeaderRowWidget(
          header: 'Cart items',
          onPressed: () {
            Navigator.of(context).pop();
          },
          buttonText: '',
          disableButton: true,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: checkoutSummaryList.length,
                shrinkWrap: true,
                itemBuilder: (context, itemIndex) {
                  final checkoutItem = checkoutSummaryList[itemIndex];

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${checkoutItem.amount}x ${checkoutItem.title.english}',
                          style: const TextStyle(
                            color: AlpacaColor.darkGreyColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          Utilities.currencyFormat(checkoutItem.totalPrice),
                          style: const TextStyle(
                            color: AlpacaColor.blackColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        const DividerWidget(),
      ],
    );
  }
}
