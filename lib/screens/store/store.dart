import 'package:alpaca/global.dart';
import 'package:alpaca/screens/store/store_screen_model.dart';
import 'package:alpaca/shared/base_screen.dart';
import 'package:alpaca/shared/page_wrapper.dart';
import 'package:alpaca/shared/viewstate.dart';
import 'package:flutter/material.dart';

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
          ? SizedBox()
          : PageWrapper(
              backgroundColor: AlpacaColor.primary100,
              child: SingleChildScrollView(
                child: Column(
                  children: [Text(model.restaurant.name)],
                ),
              ),
            ),
    );
  }
}
