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
    final store = context.select(
      (StoreInformationCubit cubit) => cubit.state.store,
    );

    return Column(
      children: [
        CheckoutNavbar(
          storeName: store.name,
          pageOverviewName: context.l10n.storeInformation,
        ),
        CrunchMap(
          googleMapsLink: store.googleMapsLink!,
          name: store.name!,
        ),
        const StoreInformation(),
      ],
    );
  }
}
