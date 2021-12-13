import 'dart:ui';

import 'package:alpaca/alpaca.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pickup/routes.dart';
import 'package:pickup/screens/store/store_screen_model.dart';
import 'package:pickup/screens/store/widgets/store_information_item.dart';
import 'package:pickup/screens/store/widgets/store_menue_list.dart';
import 'package:pickup/screens/store/widgets/store_overview.dart';
import 'package:pickup/shared/base_screen.dart';
import 'package:pickup/shared/viewstate.dart';
import 'package:sanity/sanity.dart';

class CreateStoreData {
  CreateStoreData({
    required this.checkoutItems,
    required this.storeName,
    required this.googleMaps,
  });

  final List<RestaurantMenueItemModel> checkoutItems;
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
  List<RestaurantMenueItemModel> checkoutItems = [];

  @override
  Widget build(BuildContext context) {
    
    return BaseScreen<StoreScreenModel>(
      onModelReady: (model) {
        model.fetchRestaurant(widget.storeId);
      },
      builder: (context, model, child) => model.state == ViewState.busy
          ? Container(color: AlpacaColor.white100Color)
          : PageWrapper(
              floatingActionButtonWidget: checkoutItems.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: ActionButton(
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
                        buttonText: 'Checkout',
                      ),
                    )
                  : null,
              padding: EdgeInsets.zero,
              backgroundColor: AlpacaColor.white100Color,
              statusBarStyle: SystemUiOverlayStyle.dark,
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: Image.network(
                            model.restaurant.image,
                          ).image,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 18,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () => {Navigator.of(context).pop()},
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 20,
                                color: AlpacaColor.white100Color,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 10,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                        sigmaX: 10,
                                        sigmaY: 10,
                                      ),
                                      child: IconButton(
                                        onPressed: () {},
                                        color: AlpacaColor.white100Color,
                                        icon: const Icon(
                                          Icons.star_border_outlined,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 10,
                                      sigmaY: 10,
                                    ),
                                    child: IconButton(
                                      onPressed: () {},
                                      color: AlpacaColor.white100Color,
                                      icon: const Icon(Icons.info_outline),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    StoreOverview(
                      name: model.restaurant.name,
                      rating: '4.2',
                      walkingDistance: '200',
                      walkingTime: '11',
                      googleMaps: model.restaurant.googleMapsUrl,
                    ),
                    const Divider(),
                    Padding(
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
                            description: model.restaurant.phoneNumber,
                          ),
                          StoreInformationItem(
                            icon: Icons.location_on_outlined,
                            title: 'Store address',
                            description: model.restaurant.address,
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    StoreMenueList(
                      menueCategories: model.restaurant.menueCategories,
                      onCheckoutChange: (list) {
                        setState(() {
                          checkoutItems = list;
                        });
                      },
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
