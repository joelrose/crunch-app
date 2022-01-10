import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pickup/screens/store/widgets/store_image_navbar.dart';

import '../widgets/store_menue_list.dart';
import 'product_amount_and_add_to_order.dart';
import 'product_detail_text.dart';
import 'product_radio_checkbox.dart';

class StoreProductOverview extends StatefulWidget {
  const StoreProductOverview({Key? key, required this.data}) : super(key: key);
  final ProductDetailsData data;

  @override
  _StoreProductOverviewState createState() => _StoreProductOverviewState();
}

class _StoreProductOverviewState extends State<StoreProductOverview> {
  late double totalPrice;

  @override
  void initState() {
    super.initState();
    totalPrice = 0;
  }

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      statusBarStyle: SystemUiOverlayStyle.dark,
      padding: EdgeInsets.zero,
      backgroundColor: AlpacaColor.white100Color,
      child: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              shrinkWrap: true,
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      StoreImageNavbar(
                        image: widget.data.restaurantImage,
                        showButtons: false,
                      ),
                      ProductBasicDetails(
                        title: widget.data.item.title.english,
                      ),
                      ProductRadioCheckbox(
                        itemCategories: widget.data.itemOptions,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          ProductAmountAndAddToOrder(
            data: widget.data,
            totalPrice: totalPrice,
          )
        ],
      ),
    );
  }
}
