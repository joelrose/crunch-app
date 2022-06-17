import 'package:alpaca/alpaca.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_repository/hermes_repository.dart';
import 'package:pickup/l10n/l10n.dart';
import 'package:pickup/screens/app/app.dart';
import 'package:pickup/screens/store/cubit/store_cubit.dart';
import 'package:pickup/screens/store_detail/store_detail.dart';
import 'package:pickup/shared/utilities.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class StoreMenueList extends StatelessWidget {
  const StoreMenueList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.select((StoreCubit cubit) => cubit.state);
    final menu = state.menu!;
    final menueCategories = menu.menu!.categories!;

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

  final DeliverectCategoryModelDto category;

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
        const AlpacaDivider(),
        ListView.separated(
          itemCount: category.products!.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, i) {
            return _ItemButton(
              product: category.products![i].product!,
            );
          },
          separatorBuilder: (context, index) {
            return const AlpacaDivider();
          },
        ),
        const AlpacaDivider(),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}

class _ItemButton extends StatelessWidget {
  const _ItemButton({Key? key, required this.product}) : super(key: key);

  final DeliverectProductModelDto product;

  @override
  Widget build(BuildContext context) {
    final state = context.select((StoreCubit cubit) => cubit.state);
    final menu = state.menu!;
    final checkoutItems = context.select(
      (CheckoutBasketBloc bloc) => bloc.state.checkoutItems,
    );

    final amountInBasket =
        '${_amountInTheBasket(checkoutItems, product.plu!)}x';

    return TextButton(
      onPressed: product.snoozed!
          ? null
          : () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  final checkoutBasket = context.read<CheckoutBasketBloc>();
                  return FractionallySizedBox(
                    heightFactor: 0.8,
                    child: StoreDetailPage(
                      item: product,
                      restaurantImage: menu.menu!.menuImageUrl!,
                      checkoutItems: checkoutBasket.state.checkoutItems,
                    ),
                  );
                },
              );
            },
      style: TextButton.styleFrom(
        primary: AlpacaColor.primary100,
      ),
      child: Row(
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 18, 34, 18),
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
                      if ((checkoutItems.indexWhere(
                            (checkouItem) => checkouItem.plu == product.plu,
                          )) !=
                          -1)
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            amountInBasket,
                            overflow: TextOverflow.clip,
                            style:
                                Theme.of(context).textTheme.headline4!.copyWith(
                                      color: AlpacaColor.primary80,
                                    ),
                          ),
                        ),
                    ],
                  ),
                  Container(
                    height: 10,
                  ),
                  if (product.description != null &&
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
          if (product.imageUrl != null)
            CachedNetworkImage(
              imageUrl: product.imageUrl!,
              fit: BoxFit.fitHeight,
              width: 114,
              height: 134,
            ),
        ],
      ),
    );
  }

  int _amountInTheBasket(List<CreateOrderItemDto> checkoutItems, String plu) {
    final items = checkoutItems.where(
      (listItem) => plu == listItem.plu,
    );

    return items.fold(
      0,
      (previousValue, element) => previousValue + element.quantity!,
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 18,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.l10n.menu,
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                        color: AlpacaColor.darkNavyColor,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
