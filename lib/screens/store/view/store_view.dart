import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_api/swagger_generated_code/swagger.swagger.dart';
import 'package:pickup/l10n/l10n.dart';
import 'package:pickup/screens/checkout/checkout.dart';
import 'package:pickup/screens/store/cubit/store_cubit.dart';
import 'package:pickup/screens/store/model/create_store_data.dart';
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
          return PageWrapper(
            floatingActionButtonWidget: Visibility(
              visible: state.checkoutItems!.isNotEmpty,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: CheckoutButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      CheckoutScreen.route,
                      arguments: CreateStoreData(
                        checkoutItems: state.checkoutItems!,
                        storeName: model.menu!.menu!, //model.store.,
                        googleMaps: model
                            .googleMapsLink!, //model.restaurant.googleMapsUrl,
                        merchantId: model.menu!.menuId!,
                      ),
                    );
                  },
                  buttonText:
                      '${context.l10n.storeFloatingButtonText(_getItemsInCart(state.checkoutItems))} in Cart ->',
                  priceText: Utilities.currencyFormat(
                    PriceCalulcation.getPriceOfItems(state.checkoutItems!),
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
                    StoreOverview(
                      name: model.menu?.menu ?? '',
                      rating: model.rating!.toString(),
                      googleMaps: model.googleMapsLink ?? '',
                      estimatedTime: model.averagePickUpTime ?? '20',
                      reviewCount: model.reviewCount ?? '25',
                    ),
                    const Divider(),
                    StoreInformation(
                      phoneNumer: model.phoneNumber ?? '',
                      address: model.address ?? '',
                      openingTimes: _getOpeningTimes(
                        context,
                        model.menu!.availabilities!,
                      ),
                    ),
                    const Divider(),
                    StoreMenueList(
                      menueCategories: model.menu?.categories ?? [],
                      onCheckoutChange: (list) =>
                          context.read<StoreCubit>().updateCheckoutItems(list),
                      restaurantImage: model.menu?.menuImageUrl ?? '',
                    ),
                    if (state.checkoutItems!.isNotEmpty)
                      const SizedBox(
                        height: 80,
                      ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Container(color: AlpacaColor.white100Color);
        }
      },
    );
  }

  int _getItemsInCart(List<CreateOrderItemDto>? checkoutItems) {
    return checkoutItems!.fold(0, (p, c) => p + c.quantity!);
  }

  String _getOpeningTimes(
    BuildContext context,
    List<DeliverectAvailabilityModel> availabilities,
  ) {
    final today = DateTime.now();

    final todaysOpeningHours = availabilities
        .where(
          (element) => element.dayOfWeek!.index == today.weekday,
        )
        .toList();

    String openingTimes = context.l10n.closed;
    for (final hour in todaysOpeningHours) {
      final startTime = hour.startTime!.split(':');
      // final endTime = hour.startTime!.split(':');

      final startHour = int.parse(startTime[0]);
      final startMinutes = int.parse(startTime[0]);

      if (today.hour > startHour) {
        openingTimes = '${hour.startTime!} - ${hour.endTime!}';
      } else if (today.hour == startHour && today.minute < startMinutes) {
        openingTimes = '${hour.startTime!} - ${hour.endTime!}';
      }
    }

    return openingTimes;
  }
}
