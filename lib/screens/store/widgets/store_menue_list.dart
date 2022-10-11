import 'package:alpaca/alpaca.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_repository/hermes_repository.dart';
import 'package:pickup/screens/app/app.dart';
import 'package:pickup/screens/store/cubit/store_cubit.dart';
import 'package:pickup/screens/store_detail/store_detail.dart';
import 'package:pickup/shared/utilities.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class StoreMenueList extends StatelessWidget {
  const StoreMenueList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final menueCategories =
        context.select((StoreCubit cubit) => cubit.state.store!.categories!);

    return ListView.builder(
      itemCount: menueCategories.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, j) {
        return _Item(
          category: menueCategories[j],
        );
      },
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({Key? key, required this.category}) : super(key: key);

  final GetStoreCategory category;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
          title: Text(
            category.name!,
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        ListView.builder(
          itemCount: category.products!.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, i) {
            return _ItemButton(
              product: category.products![i],
            );
          },
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}

class _ItemButton extends StatelessWidget {
  const _ItemButton({Key? key, required this.product}) : super(key: key);

  final GetStoreProduct product;

  @override
  Widget build(BuildContext context) {
    final menuImageUrl = context
        .select((StoreCubit cubit) => cubit.state.store!.imageUrl!);

    return TextButton(
      onPressed:
          product.snoozed! ? null : () => showModal(context, menuImageUrl),
      style: TextButton.styleFrom(
        primary: AlpacaColor.primary100,
        padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
      ),
      child: _ItemContent(
        product: product,
      ),
    );
  }

  void showModal(
    BuildContext context,
    String imageUrl,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.8,
          child: StoreDetailPage(
            item: product,
            restaurantImage: imageUrl,
          ),
        );
      },
    );
  }
}

class _ItemContent extends StatelessWidget {
  const _ItemContent({Key? key, required this.product}) : super(key: key);

  final GetStoreProduct product;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutBasketBloc, CheckoutBasketState>(
      buildWhen: (previous, current) =>
          previous.checkoutItems.where(
            (listItem) => product.plu! == listItem.plu,
          ) !=
          current.checkoutItems.where(
            (listItem) => product.plu! == listItem.plu,
          ),
      builder: (context, state) {
        final amountInBasket =
            _amountInTheBasket(state.checkoutItems, product.plu!);

        return Row(
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 12, 18, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            product.name!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style:
                                Theme.of(context).textTheme.headline3!.copyWith(
                                      decoration: product.snoozed!
                                          ? TextDecoration.lineThrough
                                          : null,
                                    ),
                          ),
                        ),
                        /*if (hasProductInBasket(state.checkoutItems))
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              ,
                              overflow: TextOverflow.clip,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(
                                    color: AlpacaColor.primary80,
                                  ),
                            ),
                          ),*/
                      ],
                    ),
                    Container(
                      height: 10,
                    ),
                    if (product.description != null &&
                        product.description != ' ' &&
                        product.description != '') ...[
                      Text(
                        product.description!,
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              decoration: product.snoozed!
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                      ),
                      Container(
                        height: 10,
                      ),
                    ],
                    Text(
                      Utilities.currencyFormat(product.price!),
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: AlpacaColor.primary80,
                            decoration: product.snoozed!
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            if (product.imageUrl != '')
              _Image(
                count: amountInBasket,
                imageUrl: product.imageUrl!,
              )
          ],
        );
      },
    );
  }

  bool hasProductInBasket(List<OrderItem> checkoutItems) {
    return checkoutItems.indexWhere(
          (checkouItem) => checkouItem.plu == product.plu,
        ) !=
        -1;
  }

  int _amountInTheBasket(List<OrderItem> checkoutItems, String plu) {
    final items = checkoutItems.where(
      (listItem) => plu == listItem.plu,
    );

    return items.fold(
      0,
      (previousValue, element) => previousValue + element.quantity!,
    );
  }
}

class _Image extends StatelessWidget {
  const _Image({Key? key, required this.count, required this.imageUrl})
      : super(key: key);

  final String imageUrl;

  final int count;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.contain,
          width: 130,
          fadeInDuration: Duration.zero,
          placeholder: (context, url) => SkeletonLoader(
            builder: Container(
              width: 100,
              height: 120,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
            ),
          ),
        ),
        if (count > 0) ...[
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              height: 35,
              width: 35,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: AlpacaColor.blackColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
              ),
              child: Text(
                count.toString(),
                overflow: TextOverflow.clip,
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
          ),
        ]
      ],
    );
  }
}
