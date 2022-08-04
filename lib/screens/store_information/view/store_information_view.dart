import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickup/l10n/l10n.dart';
import 'package:pickup/screens/checkout_navbar/checkout_navbar.dart';
import 'package:pickup/screens/orders_detail/order_detail.dart';
import 'package:pickup/screens/store_information/cubit/cubit.dart';
import 'package:pickup/screens/store_information/widgets/store_information.dart';

class StoreInformationView extends StatelessWidget {
  const StoreInformationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final menu = context.select(
      (StoreInformationCubit cubit) => cubit.state.menu,
    );

    return Column(
      children: [
        CheckoutNavbar(
          storeName: menu.menu!.menu,
          pageOverviewName: context.l10n.orderOverview,
        ),
        CrunchMap(
          googleMapsLink: menu.googleMapsLink!,
          name: menu.menu!.menu!,
        ),
        const StoreInformation(),
      ],
    );
  }
}
