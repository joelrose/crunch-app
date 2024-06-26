import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_repository/hermes_repository.dart';
import 'package:pickup/l10n/l10n.dart';
import 'package:pickup/screens/checkout_navbar/checkout_navbar.dart';
import 'package:pickup/screens/home/home.dart';
import 'package:pickup/screens/orders_detail/widgets/widgets.dart';
import 'package:url_launcher/url_launcher_string.dart';

class OrdersDetailPage extends StatelessWidget {
  const OrdersDetailPage({
    Key? key,
    required this.order,
  }) : super(key: key);

  final GetOrdersResponse order;

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) {
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
      },
      child: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CheckoutNavbar(
                storeName: order.storeName ?? '',
                pageOverviewName: context.l10n.orderOverview,
              ),
               CrunchMap(
                googleMapsLink: order.googleMapsLink ?? '',
                name: order.storeName ?? '',
              ),
              Detail(order: order),
              const Divider(),
              ItemList(
                items: order.orderItems!,
              ),
              ActionButton(
                key: const Key('support_button'),
                buttonText: context.l10n.support,
                isPrimaryButton: false,
                textColor: AlpacaColor.darkGreyColor,
                onPressed: () => launchUrlString('mailto:joel@getcrunch.tech'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
