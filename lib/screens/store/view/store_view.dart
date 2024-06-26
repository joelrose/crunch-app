import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_repository/hermes_repository.dart';
import 'package:pickup/l10n/l10n.dart';
import 'package:pickup/screens/app/app.dart';
import 'package:pickup/screens/checkout/presentation/screen/checkout_page.dart';
import 'package:pickup/screens/store/cubit/store_cubit.dart';
import 'package:pickup/screens/store/widgets/store_menue_list.dart';
import 'package:pickup/screens/store/widgets/store_overview.dart';
import 'package:pickup/shared/price_calculation.dart';
import 'package:pickup/shared/utilities.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class StoreView extends StatelessWidget {
  const StoreView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreCubit, StoreState>(
      builder: (context, state) {
        if (state.status.isSuccess || state.status.isReload) {
          return _Content(store: state.store!);
        } else {
          return const _SkeletonView();
        }
      },
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({Key? key, required this.store}) : super(key: key);

  final GetStoreResponse store;

  @override
  Widget build(BuildContext context) {
    final checkoutItems = context.select(
      (CheckoutBasketBloc bloc) => bloc.state.checkoutItems,
    );

    final storeFloatingButtonText =
        context.l10n.storeFloatingButtonText(_getItemsInCart(checkoutItems));
    final floatingButtonText = '$storeFloatingButtonText ->';

    return PageWrapper(
      floatingActionButtonWidget: Visibility(
        visible: checkoutItems.isNotEmpty,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: CheckoutButton(
            onPressed: () {
              HapticFeedback.mediumImpact();
              Navigator.of(context).push(
                CheckoutPage.route(
                  store: store,
                ),
              );
            },
            buttonText: floatingButtonText,
            priceText: Utilities.currencyFormat(
              PriceCalulcation.getPriceOfItems(checkoutItems),
            ),
            textColor: AlpacaColor.white100Color,
          ),
        ),
      ),
      padding: EdgeInsets.zero,
      backgroundColor: AlpacaColor.white100Color,
      statusBarStyle: SystemUiOverlayStyle.dark,
      child: AlpacaStretchyHeader(
        image: store.imageUrl ?? '',
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const StoreOverview(),
              const Divider(height: 0),
              const StoreMenueList(),
              if (checkoutItems.isNotEmpty)
                const SizedBox(
                  height: 80,
                ),
            ],
          ),
        ),
      ),
    );
  }

  int _getItemsInCart(List<OrderItem>? checkoutItems) {
    return checkoutItems!.fold(0, (p, c) => p + c.quantity!);
  }
}

class _SkeletonView extends StatelessWidget {
  const _SkeletonView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SkeletonLoader(
        builder: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            const SizedBox(
              height: 26,
            ),
            Container(
              alignment: Alignment.centerLeft,
              width: 140,
              height: 25,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              margin: const EdgeInsets.only(left: 30),
            ),
            const SizedBox(height: 15),
            Container(
              width: 112,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              margin: const EdgeInsets.only(left: 30),
            ),
            const SizedBox(height: 15),
            const Divider(
              color: Colors.white,
            ),
            const SizedBox(height: 15),
            Container(
              width: 80,
              height: 25,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              margin: const EdgeInsets.only(left: 30),
            ),
            const SizedBox(height: 10),
            const Divider(
              color: Colors.white,
            ),
            const _SkeletonTile(),
            const _SkeletonTile(),
          ],
        ),
        highlightColor: const Color(0xFFF1EFEF),
      ),
    );
  }
}

class _SkeletonTile extends StatelessWidget {
  const _SkeletonTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Container(
                    width: 130,
                    height: 18,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    margin: const EdgeInsets.only(left: 30),
                  ),
                  const SizedBox(height: 18),
                  Container(
                    width: 180,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    margin: const EdgeInsets.only(left: 30),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: 180,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    margin: const EdgeInsets.only(left: 30),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: 180,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    margin: const EdgeInsets.only(left: 30),
                  ),
                  const SizedBox(height: 14),
                  Container(
                    width: 40,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    margin: const EdgeInsets.only(left: 30),
                  ),
                ],
              ),
              Container(
                width: 115,
                height: 130,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
                margin: const EdgeInsets.only(left: 30),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        const Divider(
          color: Colors.white,
        ),
      ],
    );
  }
}
