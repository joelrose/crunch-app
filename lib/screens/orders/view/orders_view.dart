import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hermes_api/hermes_api.dart';
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
              return Expanded(
                child: RefreshIndicator(
                  color: AlpacaColor.primary100,
                  onRefresh: () => context.read<OrdersCubit>().fetchOrders(),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height - 200,
                    child: _buildListView(state.orders),
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

  Widget _buildListView(List<GetOrderResponseDto> orders) {
    if (orders.isNotEmpty) {
      return ListView.builder(
        itemCount: orders.length,
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return OrdersListView(
            order: orders.elementAt(index),
          );
        },
      );
    } else {
      return ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 150),
            child: SvgPicture.asset(
              'assets/no-data.svg',
              height: 200,
            ),
          ),
        ],
      );
    }
  }
}
