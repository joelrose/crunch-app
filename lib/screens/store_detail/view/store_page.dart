import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_repository/hermes_repository.dart';
import 'package:pickup/screens/app/app.dart';
import 'package:pickup/screens/store_detail/cubit/store_detail_cubit.dart';
import 'package:pickup/screens/store_detail/widgets/product_detail.dart';
import 'package:pickup/screens/store_detail/widgets/product_option_widget.dart';
import 'package:pickup/screens/store_detail/widgets/product_order_widget.dart';

class StoreDetailPage extends StatelessWidget {
  const StoreDetailPage({
    Key? key,
    required this.item,
    required this.restaurantImage,
    required this.checkoutItems,
  }) : super(key: key);

  final DeliverectProductModelDto item;
  final String restaurantImage;
  final List<CreateOrderItemDto> checkoutItems;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StoreDetailCubit(
        checkoutItems: checkoutItems,
        item: item,
      ),
      child: BlocListener<StoreDetailCubit, StoreDetailState>(
        listener: (context, state) {
          if (state.status == StoreDetailStatus.done) {
            context.read<CheckoutBasketBloc>().add(
                  CheckoutBasketItemUpdated(checkoutItems: state.checkoutItems),
                );
            Navigator.pop(context);
          }
        },
        child: StoreDetailView(
          image: item.imageUrl ?? restaurantImage,
        ),
      ),
    );
  }
}

class StoreDetailView extends StatelessWidget {
  const StoreDetailView({Key? key, required this.image}) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: AlpacaStretchyHeader(
            image: image,
            child: Column(
              children: const [
                ProductDetailWidget(),
                ProductOptionWidget(),
              ],
            ),
          ),
        ),
        ProductOrderWidget()
      ],
    );
  }
}
