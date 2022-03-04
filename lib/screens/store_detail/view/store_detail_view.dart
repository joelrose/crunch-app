import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pickup/screens/store_detail/widgets/widgets.dart';
import 'package:pickup/shared/alpaca_stretchy_header.dart';

class StoreDetailView extends StatelessWidget {
  const StoreDetailView({Key? key, required this.image}) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      statusBarStyle: SystemUiOverlayStyle.dark,
      padding: EdgeInsets.zero,
      backgroundColor: AlpacaColor.white100Color,
      child: Column(
        children: [
          Expanded(
            child: AlpacaStretchyHeader(
              image: image,
              child: Column(
                children: const [ProductBasicDetails(), ProductRadioCheckbox()],
              ),
            ),
          ),
          const ProductAmountAndAddToOrder()
        ],
      ),
    );
  }
}
