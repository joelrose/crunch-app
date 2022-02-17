import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickup/screens/orders/cubit/orders_cubit.dart';
import 'package:pickup/screens/orders/widgets/widgets.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
            if (state.status.isSuccess) {
              return RefreshIndicator(
                color: AlpacaColor.primary100,
                onRefresh: () => context.read<OrdersCubit>().fetchOrders(),
                child: ListView.builder(
                  itemCount: state.orders.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return OrdersListView(
                      order: state.orders.elementAt(index),
                    );
                  },
                ),
              );
            } else {
              return const OrdersLoadingView();
            }
          },
        ),
      ],
    );
  }
}
