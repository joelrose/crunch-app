import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:hermes_repository/hermes_repository.dart';
import 'package:intl/intl.dart';
import 'package:pickup/shared/utilities.dart';

class OrdersListView extends StatelessWidget {
  const OrdersListView({Key? key, required this.order}) : super(key: key);

  final GetOrderResponseDto order;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () => Navigator.of(context).pushNamed('/detail', arguments: order),
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
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            child: Text(
                              '#${order.id!.substring(0, 3)}',
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order.merchant!.name!,
                              style: theme.textTheme.headline3,
                            ),
                            Text(
                              order.merchant!.address!,
                              style: theme.textTheme.headline5,
                            ),
                          ],
                        )
                      ],
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                      color: AlpacaColor.lightGreyColor100,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Expanded(
                      //   child: ListView.builder(
                      //     itemCount: order.items?.length ?? 0,
                      //     shrinkWrap: true,
                      //     physics: const NeverScrollableScrollPhysics(),
                      //     itemBuilder: (context, index) {
                      //       final item = order.items!.elementAt(index);
                      //       return Padding(
                      //         padding: const EdgeInsets.only(top: 10, left: 2),
                      //         child: Text(
                      //           '\u2022 1x ${item.name!}',
                      //           style: theme.textTheme.headline5,
                      //         ),
                      //       );
                      //     },
                      //   ),
                      // ),
                      Row(
                        children: [
                          Text(
                            DateFormat('dd.MM.yyyy, kk:mm')
                                .format(order.estimatedPickUpTime!),
                          ),
                          Text(
                            ' - ${order.status!.string}',
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
