import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_repository/hermes_repository.dart';
import 'package:pickup/l10n/l10n.dart';
import 'package:pickup/screens/app/app.dart';
import 'package:pickup/screens/checkout/checkout.dart';
import 'package:pickup/screens/store/cubit/store_cubit.dart';
import 'package:pickup/screens/store/widgets/store_information.dart';
import 'package:pickup/screens/store/widgets/store_menue_list.dart';
import 'package:pickup/screens/store/widgets/store_overview.dart';
import 'package:pickup/shared/price_calculation.dart';
import 'package:pickup/shared/utilities.dart';

class StoreView extends StatelessWidget {
  const StoreView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreCubit, StoreState>(
      builder: (context, state) {
        if (state.status.isSuccess || state.status.isReload) {
          final model = state.menu!;

          return Builder(builder: (context) {
            final checkoutItems = context
                .select((CheckoutBasketBloc bloc) => bloc.state.checkoutItems);

            return PageWrapper(
              floatingActionButtonWidget: Visibility(
                visible: checkoutItems.isNotEmpty,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CheckoutButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        CheckoutPage.route(
                          menu: model,
                        ),
                      );
                    },
                    buttonText:
                        '${context.l10n.storeFloatingButtonText(_getItemsInCart(checkoutItems))} in Cart ->',
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
                image: model.menu?.menuImageUrl ?? '',
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const StoreOverview(),
                      const Divider(),
                      const StoreInformation(),
                      const Divider(),
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
          });
        } else {
          return Container(color: AlpacaColor.white100Color);
        }
      },
    );
  }

  int _getItemsInCart(List<CreateOrderItemDto>? checkoutItems) {
    return checkoutItems!.fold(0, (p, c) => p + c.quantity!);
  }
}
