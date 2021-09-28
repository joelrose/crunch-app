import 'dart:math';
import 'dart:ui';

import 'package:alpaca/global.dart';
import 'package:alpaca/screens/store/store_screen_model.dart';
import 'package:alpaca/screens/store/widgets/store_information_item.dart';
import 'package:alpaca/screens/store/widgets/store_menue_list.dart';
import 'package:alpaca/screens/store/widgets/store_overview.dart';
import 'package:alpaca/shared/base_screen.dart';
import 'package:alpaca/shared/page_wrapper.dart';
import 'package:alpaca/shared/viewstate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:alpaca/shared/buttons.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({Key? key, required this.storeId}) : super(key: key);

  final String storeId;

  @override
  Widget build(BuildContext context) {
    return BaseScreen<StoreScreenModel>(
      onModelReady: (model) {
        model.fetchRestaurant(storeId);
      },
      builder: (context, model, child) => model.state == ViewState.busy
          ? Container(color: AlpacaColor.white100Color)
          : PageWrapper(
              padding: EdgeInsets.zero,
              backgroundColor: AlpacaColor.white100Color,
              statusBarStyle: SystemUiOverlayStyle.dark,
              child: SingleChildScrollView(
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
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Row(
                        children: [
                          const Spacer(),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: SizedBox(
                              height: 40,
                              width: 40,
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: IconButton(
                                  onPressed: () {},
                                  color: AlpacaColor.white100Color,
                                  icon: const Icon(Icons.star_border_outlined),
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
                                filter:
                                    ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: IconButton(
                                  onPressed: () {},
                                  color: AlpacaColor.white100Color,
                                  icon: const Icon(Icons.info_outline),
                                ),
                              ),
                            ),
                          )
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
                                    color: Color(0xff2b2d42),
                                    fontSize: 18,
                                    fontFamily: "Inter",
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
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
