import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_api/hermes_api.dart';
import 'package:pickup/screens/orders/cubit/orders_cubit.dart';
import 'package:pickup/screens/orders/view/orders_view.dart';
import 'package:pickup/screens/orders_detail/order_detail.dart';
import 'package:pickup/services/hermes_service.dart';
import 'package:pickup/services/service_locator.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OrdersCubit(
        locator<HermesService>(),
      ),
      child: Navigator(
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(
            settings: settings,
            builder: (BuildContext context) {
              switch (settings.name) {
                case '/':
                  return const OrdersView();
                case '/detail':
                  final data = settings.arguments!;

                  return OrdersDetailPage(order: data as GetOrderResponseDto);
              }
              return Container();
            },
          );
        },
      ),
    );
  }
}
