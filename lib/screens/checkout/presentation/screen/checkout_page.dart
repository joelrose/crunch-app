import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_repository/hermes_repository.dart';
import 'package:loading_overlay_repository/loading_overlay_repository.dart';
import 'package:pickup/l10n/l10n.dart';
import 'package:pickup/screens/app/app.dart';
import 'package:pickup/screens/checkout/cubits/checkout_cubit/checkout_cubit.dart';
import 'package:pickup/screens/checkout/cubits/checkout_payment_cubit/checkout_payment_cubit.dart';
import 'package:pickup/screens/checkout/cubits/checkout_timer_cubit/checkout_time_cubit.dart';
import 'package:pickup/screens/checkout/presentation/screen/checkout_confirmation_page.dart';
import 'package:pickup/screens/checkout/presentation/widgets/checkout_timer.dart';
import 'package:pickup/screens/checkout/presentation/widgets/items_overview.dart';
import 'package:pickup/screens/checkout/presentation/widgets/price_summary.dart';
import 'package:pickup/screens/checkout_navbar/checkout_navbar.dart';
import 'package:pickup/screens/checkout_row_header/checkout_row_header.dart';
import 'package:stripe_repository/stripe_repository.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  static Route<void> route({
    required GetStoreResponse store,
  }) {
    return MaterialPageRoute(
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => CheckoutCubit(store: store),
          ),
          BlocProvider(
            create: (_) => CheckoutTimeCubit(
              currentTime: DateTime.now(),
              openingHours: store.openingHours!,
            ),
          ),
          BlocProvider(
            create: (context) => CheckoutPaymentCubit(
              stripeRepository: context.read<StripeRepository>(),
              storeId: store.id!,
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
          final store = context.read<CheckoutCubit>().state.store;

          Navigator.of(context).push(
            CheckoutConfirmationPage.route(
              pickUpTime: DateTime.now()
                  .add(Duration(minutes: store.averageReview?.toInt() ?? 0)),
              googleMapsLink: store.googleMapsLink!,
            ),
          );
          context.read<LoadingOverlayRepository>().hide();
        } else if (state.status.isLoading) {
          context.read<LoadingOverlayRepository>().show();
        } else if (state.status.isFailed) {
          context.read<LoadingOverlayRepository>().hide();

          final snackBar = SnackBar(
            content: Text(context.l10n.connectionPaymentFail),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else if (state.status.isCancelled) {
          context.read<LoadingOverlayRepository>().hide();
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
        context.select((CheckoutCubit cubit) => cubit.state.store.name);

    return Column(
      children: [
        CheckoutNavbar(
          storeName: storeName,
          pageOverviewName: context.l10n.orderOverview,
        ),
        Flexible(
          child: SingleChildScrollView(
            child: Column(
              children: [
                CheckoutRowHeader(
                  header: context.l10n.checkoutCartItems,
                  onPressed: () => Navigator.of(context).pop(),
                  buttonText: context.l10n.edit,
                  disableButton: true,
                ),
                const ItemsOverview(),
                CheckoutTimer(),
                const Divider(),
                const PriceSummary(),
                Container(
                  height: 65,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
