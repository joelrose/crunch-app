import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hermes_api/swagger_generated_code/swagger.swagger.dart';
import 'package:pickup/screens/checkout/checkout.dart';
import 'package:pickup/screens/store/model/store_screen_model.dart';
import 'package:pickup/screens/store/widgets/store_information.dart';
import 'package:pickup/screens/store/widgets/store_menue_list.dart';
import 'package:pickup/screens/store/widgets/store_overview.dart';
import 'package:pickup/shared/alpaca_stretchy_header.dart';
import 'package:pickup/shared/base_screen.dart';
import 'package:pickup/shared/enum/viewstate.dart';
import 'package:pickup/shared/extensions.dart';
import 'package:pickup/shared/utilities.dart';

class CreateStoreData {
  CreateStoreData({
    required this.checkoutItems,
    required this.storeName,
    required this.googleMaps,
    required this.merchantId,
  });

  final List<CreateOrderItemDto> checkoutItems;
  final String storeName;
  final String googleMaps;
  final String merchantId;
}

class StoreScreen extends StatefulWidget {
  const StoreScreen({Key? key, required this.storeId}) : super(key: key);
  static const route = '/store';

  final String storeId;

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  bool showCheckoutButton = false;
  List<CreateOrderItemDto> checkoutItems = [];

  @override
  Widget build(BuildContext context) {
    return BaseScreen<StoreScreenModel>(
      onModelReady: (model) {
        model.fetchRestaurant(widget.storeId);
      },
      builder: (context, model, child) {
        if (model.state == ViewState.busy) {
          return Container(color: AlpacaColor.white100Color);
        } else {
          final menu = model.store.menu!;
          return PageWrapper(
            floatingActionButtonWidget: Visibility(
              visible: checkoutItems.isNotEmpty,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: CheckoutButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      CheckoutScreen.route,
                      arguments: CreateStoreData(
                        checkoutItems: checkoutItems,
                        storeName: menu.menu!, //model.store.,
                        googleMaps: model.store
                            .googleMapsLink!, //model.restaurant.googleMapsUrl,
                        merchantId: model.store.id!,
                      ),
                    );
                  },
                  buttonText:
                      '${_getItemsInCart(checkoutItems)} item in Cart ->',
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
              image: menu.menuImageUrl ?? '',
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    StoreOverview(
                      name: menu.menu ?? '',
                      rating: model.store.rating!.toString(),
                      googleMaps: model.store.googleMapsLink ?? '',
                      estimatedTime: model.store.averagePickUpTime ?? '20',
                      reviewCount: model.store.reviewCount ?? '25',
                    ),
                    const Divider(),
                    StoreInformation(
                      phoneNumer: model.store.phoneNumber ?? '',
                      address: model.store.address ?? '',
                      openingTimes: _getOpeningTimes(
                        menu.availabilities!,
                      ),
                    ),
                    const Divider(),
                    StoreMenueList(
                      menueCategories: menu.categories ?? [],
                      onCheckoutChange: (list) {
                        setState(() {
                          checkoutItems = list;
                        });
                      },
                      restaurantImage: menu.menuImageUrl ?? '',
                    ),
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
      },
    );
  }

  int _getItemsInCart(List<CreateOrderItemDto>? checkoutItems) {
    return checkoutItems!.fold(0, (p, c) => p + c.quantity!);
  }

  String _getOpeningTimes(List<DeliverectAvailabilityModel> availabilities) {
    final today = DateTime.now();

    final todaysOpeningHours = availabilities
        .where(
          (element) => element.dayOfWeek!.index == today.weekday,
        )
        .toList();

    String openingTimes = 'Closed';
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
