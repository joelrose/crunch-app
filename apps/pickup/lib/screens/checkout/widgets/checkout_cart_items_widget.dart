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

class CheckOutVM {
  // TASK: Sumarise the checkout items by grouping same items and counting them

  CheckOutVM(List<CheckoutItemModel> checkoutItems) {
    groupItems(checkoutItems);
  }

  //each induvidual item with count
  List<CheckoutItemAmount> checkoutSummaryList = [];

  void groupItems(List<CheckoutItemModel> checkoutItems) {
    for (final item in checkoutItems) {
      if (!alreadyInList(checkoutSummaryList, item)) {
        // calculate
        final int amount = countInList(checkoutItems, item);
        final double totalPrice = (item.price * amount).toDouble();
        // add
        checkoutSummaryList.add(
          CheckoutItemAmount(
            id: item.id,
            title: item.title,
            amount: amount,
            totalPrice: totalPrice,
          ),
        );
      }
    }
  }

  bool alreadyInList(
      List<CheckoutItemAmount> summaryList, CheckoutItemModel item) {
    if (summaryList.isEmpty) {
      return false;
    }
    for (final itemInList in summaryList) {
      if (itemInList.id == item.id) {
        return true;
      }
    }
    return false;
  }

  int countInList(
      List<CheckoutItemModel> checkoutList, CheckoutItemModel item) {
    int count = 0;
    for (final itemInList in checkoutList) {
      if (itemInList.id == item.id) {
        count += 1;
      }
    }
    return count;
  }
}

class CheckoutCartItemsWidget extends StatelessWidget {
  const CheckoutCartItemsWidget({Key? key, required this.checkoutItems})
      : super(key: key);

  final List<CheckoutItemModel> checkoutItems;

  @override
  Widget build(BuildContext context) {
    final CheckOutVM vm = CheckOutVM(checkoutItems);
    final List<CheckoutItemAmount> checkoutSummaryList = vm.checkoutSummaryList;

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
