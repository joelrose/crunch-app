import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:pickup/screens/store/widgets/store_image_navbar.dart';
import 'package:sanity/src/model.dart';

import 'widgets/store_menue_list.dart';

class StoreProductOverview extends StatefulWidget {
  StoreProductOverview({Key? key, required this.data}) : super(key: key);
  ProductDetailsData data;

  @override
  _StoreProductOverviewState createState() => _StoreProductOverviewState();
}

class _StoreProductOverviewState extends State<StoreProductOverview> {
  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      padding: EdgeInsets.zero,
      backgroundColor: AlpacaColor.white100Color,
      child: Column(
        children: [
          StoreImageNavbar(
            image: widget.data.restaurantImage,
            showButtons: false,
          )
        ],
      ),
    );
  }
}
