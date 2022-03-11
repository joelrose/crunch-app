import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickup/screens/store_detail/cubit/store_detail_cubit.dart';
import 'package:pickup/screens/store_detail/widgets/product_amount_and_add_to_order.dart';
import 'package:pickup/screens/store_detail/widgets/product_detail_text.dart';
import 'package:pickup/screens/store_detail/widgets/product_radio_checkbox.dart';
import 'package:pickup/shared/alpaca_stretchy_header.dart';
import 'package:pickup/shared/models/product_detail_model.dart';

class StoreDetailPage extends StatelessWidget {
  const StoreDetailPage({Key? key, required this.data}) : super(key: key);

  static const route = '/store/product';

  final ProductDetailsData data;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StoreDetailCubit(data),
      child: StoreDetailView(
        image: data.item.imageUrl ?? data.restaurantImage,
      ),
    );
  }
}

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
                children: const [
                  ProductBasicDetails(),
                  ProductRadioCheckbox(),
                ],
              ),
            ),
          ),
          const ProductAmountAndAddToOrder()
        ],
      ),
    );
  }
}
