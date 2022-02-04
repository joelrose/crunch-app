
import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pickup/screens/store/store_screen_model.dart';
import 'package:pickup/screens/store/widgets/store_image_navbar.dart';
import 'package:pickup/screens/store/widgets/store_information_item.dart';
import 'package:pickup/screens/store/widgets/store_menue_list.dart';
import 'package:pickup/screens/store/widgets/store_overview.dart';
import 'package:pickup/shared/base_screen.dart';
import 'package:pickup/shared/extensions.dart';
import 'package:pickup/shared/routes.dart';
import 'package:pickup/shared/utilities.dart';
import 'package:pickup/shared/viewstate.dart';
import 'package:sanity/sanity.dart';

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
                        storeCheckoutRoute,
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
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    StoreImageNavbar(image: model.restaurant.image),
                    StoreOverview(
                      name: model.restaurant.name,
                      rating: '4.8',
                      walkingDistance: '200',
                      walkingTime: '11',
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
    );
  }
}

class StoreInformation extends StatelessWidget {
  const StoreInformation({
    Key? key,
    required this.phoneNumer,
    required this.address,
  }) : super(key: key);

  final String phoneNumer;
  final String address;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Store information',
                  style: TextStyle(
                    color: AlpacaColor.darkNavyColor,
                    fontSize: 18,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 30,
                ),
              ],
            ),
          ),
          const StoreInformationItem(
            icon: Icons.access_time,
            title: 'Opening times',
            description: '11:00-22:00',
          ),
          StoreInformationItem(
            icon: Icons.phone_outlined,
            title: 'Contact number',
            description: phoneNumer,
          ),
          StoreInformationItem(
            icon: Icons.location_on_outlined,
            title: 'Store address',
            description: address,
          ),
        ],
      ),
    );
  }
}
