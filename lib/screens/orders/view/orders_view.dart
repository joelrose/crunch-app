import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hermes_repository/hermes_repository.dart';
import 'package:pickup/l10n/l10n.dart';
import 'package:pickup/screens/orders/cubit/orders_cubit.dart';
import 'package:pickup/screens/orders/widgets/widgets.dart';

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
            context.l10n.myOrders,
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
              return Expanded(
                child: RefreshIndicator(
                  color: AlpacaColor.primary100,
                  onRefresh: () => context.read<OrdersCubit>().fetchOrders(),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height - 200,
                    child: _ListView(orders: state.orders),
                  ),
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

class _ListView extends StatelessWidget {
  const _ListView({Key? key, required this.orders}) : super(key: key);

  final List<GetOrdersResponse> orders;

  @override
  Widget build(BuildContext context) {
    return orders.isNotEmpty
        ? ListView.builder(
            itemCount: orders.length,
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return OrdersListView(
                order: orders.elementAt(index),
              );
            },
          )
        : ListView(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 150),
                    child: SvgPicture.asset(
                      'assets/no-data.svg',
                      height: 160,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    width: 220,
                    child: Text(
                      context.l10n.ordersEmpty,
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(color: AlpacaColor.blackColor),
                          textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ],
          );
  }
}
