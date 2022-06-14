import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_repository/hermes_repository.dart';
import 'package:pickup/l10n/l10n.dart';
import 'package:pickup/screens/app/app.dart';
import 'package:pickup/screens/checkout/cubit/cubit.dart';
import 'package:pickup/screens/checkout/widgets/widgets.dart';
import 'package:pickup/screens/checkout_confirmation/checkout_confirmation.dart';
import 'package:pickup/screens/checkout_navbar/checkout_navbar.dart';
import 'package:pickup/screens/checkout_row_header/checkout_row_header.dart';
import 'package:pickup/screens/checkout_time_picker/checkout_pickup_widget.dart';
import 'package:pickup/shared/show_async_loading.dart';
import 'package:stripe_repository/stripe_repository.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  static Route<void> route({
    required GetMenuResponseDto menu,
  }) {
    return MaterialPageRoute(
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => CheckoutCubit(menu: menu),
          ),
          BlocProvider(
            create: (_) => CheckoutTimeCubit(),
          ),
          BlocProvider(
            create: (context) => CheckoutPaymentCubit(
              stripeRepository: context.read<StripeRepository>(),
              merchantId: menu.id!,
            ),
          ),
        ],
        child: const CheckoutPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CheckoutPaymentCubit, CheckoutPaymentState>(
      listener: (context, state) {
        if (state.status.isPaid) {
          Navigator.of(context).push(
            CheckoutConfirmationPage.route(),
          );
          LoadingUtils.hide();
        } else if (state.status.isLoading) {
          LoadingUtils.show();
        } else if (state.status.isFailed) {
          LoadingUtils.hide();

          final snackBar = SnackBar(
            content: Text(context.l10n.connectionPaymentFail),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: PageWrapper(
        padding: EdgeInsets.zero,
        statusBarStyle: SystemUiOverlayStyle.dark,
        backgroundColor: AlpacaColor.white100Color,
        floatingActionButtonWidget: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: ActionButton(
            onPressed: () {
              final checkoutItems =
                  context.read<CheckoutBasketBloc>().state.checkoutItems;
              context.read<CheckoutPaymentCubit>().checkout(checkoutItems);
            },
            buttonText: context.l10n.buttonPayLabel,
          ),
        ),
        child: const _Content(),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final storeName =
        context.select((CheckoutCubit cubit) => cubit.state.menu.menu!.menu!);

    return Column(
      children: [
        CheckoutNavbar(
          storeName: storeName,
          pageOverviewName: context.l10n.orderOverview,
        ),
        Flexible(
          child: ListView(
            children: [
              CheckoutRowHeader(
                header: context.l10n.checkoutCartItems,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                buttonText: context.l10n.edit,
              ),
              const ItemsOverview(),
              const Divider(),
              const CheckoutTimePicker(),
              const AddressDirection(),
              const ContactDetails(),
              const PriceSummary(),
              Container(
                height: 65,
              )
            ],
          ),
        ),
      ],
    );
  }
}
