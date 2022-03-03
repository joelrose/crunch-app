import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:hermes_api/hermes_api.dart';
import 'package:pickup/screens/orders/view/order_detail_view.dart';

class OrdersListView extends StatelessWidget {
  const OrdersListView({Key? key, required this.order}) : super(key: key);

  final GetOrderResponseDto order;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () => Navigator.of(context)
          .pushNamed(OrderDetailView.route, arguments: order),
      splashColor: AlpacaColor.primary20,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            right: 15,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AlpacaColor.lightGreyColor90,
                              width: 2,
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            child: Text(
                              '#32',
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order.storeId.toString(),
                              style: theme.textTheme.headline3,
                            ),
                            Text(
                              'Pfarrstrase 100 · 12/09/21',
                              style: theme.textTheme.headline5,
                            ),
                          ],
                        )
                      ],
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                      color: Color(0xff7D8589),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: order.items?.length ?? 0,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final item = order.items!.elementAt(index);
                          return Padding(
                            padding: const EdgeInsets.only(top: 10, left: 2),
                            child: Text(
                              '\u2022 1x ${item.name!}',
                              style: theme.textTheme.headline5,
                            ),
                          );
                        },
                      ),
                    ),
                    Text(
                      '${order.price!.toStringAsFixed(2)} €',
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                            color: AlpacaColor.primary100,
                          ),
                    ),
                  ],
                )
              ],
            ),
          ),
          const AlpacaDivider(),
        ],
      ),
    );
  }
}
