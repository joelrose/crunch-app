import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pickup/screens/orders/cubit/orders_cubit.dart';
import 'package:pickup/services/hermes_service.dart';
import 'package:pickup/services/service_locator.dart';
import 'package:pickup/shared/alpaca_divider.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = OrdersCubit(
          locator<HermesService>(),
        );
        cubit.fetchOrders();
        return cubit;
      },
      child: const OrdersView(),
    );
  }
}

class OrdersView extends StatelessWidget {
  const OrdersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          child: Text(
            'My orders',
            style: Theme.of(context).textTheme.headline1!.merge(
                  const TextStyle(
                    color: AlpacaColor.blackColor,
                  ),
                ),
          ),
        ),
        const AlpacaDivider(),
        BlocBuilder<OrdersCubit, OrdersState>(
          builder: (context, state) {
            if (state.status == OrdersStatus.success) {
              return Expanded(
                child: ListView.builder(
                  itemCount: state.orders.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final order = state.orders.elementAt(index);
                    return InkWell(
                      onTap: () {},
                      splashColor: AlpacaColor.primary20,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(
                                            right: 15,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                              color:
                                                  AlpacaColor.lightGreyColor90,
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                  children: [
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: order.items?.length ?? 0,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          final item =
                                              order.items!.elementAt(index);
                                          return Text(item.name!);
                                        },
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
                  },
                ),
              );
            }

            return Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/under-construction.svg',
                    height: 200,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 40,
                    ),
                    child: Text(
                      'Hey, we building something great here. Stay tuned!',
                      style: Theme.of(context).textTheme.bodyText1!.merge(
                            const TextStyle(
                              color: AlpacaColor.darkGreyColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(height: 100)
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
