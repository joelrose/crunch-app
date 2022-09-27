import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_repository/hermes_repository.dart';
import 'package:pickup/screens/app/app.dart';
import 'package:pickup/screens/store_detail/store_detail.dart';

class StoreDetailPage extends StatelessWidget {
  const StoreDetailPage({
    Key? key,
    required this.item,
    required this.restaurantImage,
  }) : super(key: key);

  final GetStoreProduct item;
  final String restaurantImage;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StoreDetailCubit(
        item: item,
      ),
      child: BlocListener<StoreDetailCubit, StoreDetailState>(
        listener: (context, state) {
          if (state.status == StoreDetailStatus.done) {
            final orderItem =
                context.read<StoreDetailCubit>().createOrderItemDto();

            context.read<CheckoutBasketBloc>().add(
                  CheckoutBasketItemAdded(item: orderItem),
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
                ProductDetail(),
                ProductOptions(),
              ],
            ),
          ),
        ),
        ProductOrder()
      ],
    );
  }
}
