import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pickup/screens/checkout/checkout.dart';
import 'package:pickup/screens/store/store_screen_model.dart';
import 'package:pickup/screens/store/widgets/store_information.dart';
import 'package:pickup/screens/store/widgets/store_menue_list.dart';
import 'package:pickup/screens/store/widgets/store_overview.dart';
import 'package:pickup/shared/base_screen.dart';
import 'package:pickup/shared/enum/viewstate.dart';
import 'package:pickup/shared/extensions.dart';
import 'package:pickup/shared/utilities.dart';
import 'package:sanity/sanity.dart';
import 'package:stretchy_header/stretchy_header.dart';

class CreateStoreData {
  CreateStoreData({
    required this.checkoutItems,
    required this.storeName,
    required this.googleMaps,
  });

  final List<CheckoutItemModel> checkoutItems;
  final String storeName;
  final String googleMaps;
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
  List<CheckoutItemModel> checkoutItems = [];

  @override
  Widget build(BuildContext context) {
    return BaseScreen<StoreScreenModel>(
      onModelReady: (model) {
        model.fetchRestaurant(widget.storeId);
      },
      builder: (context, model, child) => model.state == ViewState.busy
          ? Container(color: AlpacaColor.white100Color)
          : PageWrapper(
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
                          storeName: model.restaurant.name,
                          googleMaps: model.restaurant.googleMapsUrl,
                        ),
                      );
                    },
                    buttonText: '${checkoutItems.length} item in Cart ->',
                    priceText: Utilities.currencyFormat(
                      checkoutItems.getTotalPrice(),
                    ),
                    textColor: AlpacaColor.white100Color,
                  ),
                ),
              ),
              padding: EdgeInsets.zero,
              backgroundColor: AlpacaColor.white100Color,
              statusBarStyle: SystemUiOverlayStyle.dark,
              child: StretchyHeader.singleChild(
                headerData: HeaderData(
                  headerHeight: 200,
                  header: Image.network(
                    model.restaurant.image,
                    fit: BoxFit.cover,
                  ),
                  blurContent: false,
                  // overlay:
                ),
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // StoreImageNavbar(image: model.restaurant.image),
                      StoreOverview(
                        name: model.restaurant.name,
                        rating: '4.8',
                        googleMaps: model.restaurant.googleMapsUrl,
                      ),
                      const Divider(),
                      StoreInformation(
                        phoneNumer: model.restaurant.phoneNumber,
                        address: model.restaurant.address,
                      ),
                      const Divider(),
                      StoreMenueList(
                        menueCategories: model.restaurant.menueCategories,
                        onCheckoutChange: (list) {
                          setState(() {
                            checkoutItems = list;
                          });
                        },
                        restaurantImage: model.restaurant.image,
                      ),
                      if (checkoutItems.isNotEmpty)
                        const SizedBox(
                          height: 80,
                        ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
