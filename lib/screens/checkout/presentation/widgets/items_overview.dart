import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickup/screens/app/app.dart';
import 'package:pickup/shared/shared.dart';

class ItemsOverview extends StatelessWidget {
  const ItemsOverview({Key? key, this.isEditable = true}) : super(key: key);

  final bool isEditable;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CheckoutBasketBloc, CheckoutBasketState>(
      listener: (context, state) {
        if (state.checkoutItems.isEmpty) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            const Divider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 18),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.checkoutItems.length,
                shrinkWrap: true,
                itemBuilder: (context, itemIndex) {
                  final checkoutSummaryItem = state.checkoutItems[itemIndex];
                  return OrderItemWidget(
                    item: checkoutSummaryItem,
                    isEditable: isEditable,
                    itemIndex: itemIndex,
                  );
                },
              ),
            ),
            const Divider(),
          ],
        );
      },
    );
  }
}
