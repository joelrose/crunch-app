import 'package:alpaca/alpaca.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hermes_api/hermes_api.dart';
import 'package:pickup/screens/store_detail/view/store_detail.dart';
import 'package:pickup/shared/models/product_detail_model.dart';
import 'package:pickup/shared/utilities.dart';

class StoreMenueList extends StatefulWidget {
  const StoreMenueList({
    Key? key,
    required this.menueCategories,
    required this.onCheckoutChange,
    required this.restaurantImage,
  }) : super(key: key);

  final List<DeliverectCategoryModelDto> menueCategories;
  final void Function(List<CreateOrderItemDto>) onCheckoutChange;
  final String restaurantImage;

  @override
  State<StoreMenueList> createState() => _StoreMenueListState();
}

class _StoreMenueListState extends State<StoreMenueList> {
  late final SlidableController slidableController;
  List<CreateOrderItemDto> checkoutItems = [];

  @override
  void initState() {
    slidableController = SlidableController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
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
                      'Menu',
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                            color: AlpacaColor.darkNavyColor,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        ListView.builder(
          itemCount: widget.menueCategories.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, j) {
            final category = widget.menueCategories[j];
            return Column(
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.fromLTRB(25, 15, 0, 0),
                  title: Text(
                    category.name!,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
                const AlpacaDivider(),
                ListView.separated(
                  itemCount: category.products?.length ?? 0,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, i) {
                    final item = category.products![i].product!;
                    return TextButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return FractionallySizedBox(
                              heightFactor: 0.8,
                              child: StoreDetailPage(
                                data: ProductDetailsData(
                                  item: item,
                                  restaurantImage: widget.restaurantImage,
                                  checkoutItems: checkoutItems,
                                  onCheckoutChange: widget.onCheckoutChange,
                                ),
                              ),
                            );
                          },
                        );
                        // Navigator.of(context).pushNamed(
                        //   StoreDetailPage.route,
                        //   arguments:
                        // );
                      },
                      style: TextButton.styleFrom(
                        primary: AlpacaColor.primary100,
                      ),
                      child: Row(
                        children: [
                          Flexible(
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(18, 18, 34, 18),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          item.name!,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline3,
                                        ),
                                      ),
                                      if ((checkoutItems.indexWhere(
                                            (checkouItem) =>
                                                checkouItem.plu == item.plu,
                                          )) !=
                                          -1)
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8),
                                          child: Text(
                                            '${_amountInTheBasket(item.plu!)}x',
                                            overflow: TextOverflow.clip,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4!
                                                .copyWith(
                                                  color: AlpacaColor.primary80,
                                                ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  Container(
                                    height: 10,
                                  ),
                                  if (item.description != null &&
                                      item.description != '') ...[
                                    Text(
                                      item.description!,
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ),
                                    Container(
                                      height: 10,
                                    ),
                                  ],
                                  Text(
                                    Utilities.currencyFormat(item.price!),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(color: AlpacaColor.primary80),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (item.imageUrl != null)
                            CachedNetworkImage(
                              imageUrl: item.imageUrl!,
                              fit: BoxFit.fitHeight,
                              width: 114,
                              height: 134,
                            ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const AlpacaDivider();
                  },
                ),
                const AlpacaDivider(),
              ],
            );
          },
        ),
      ],
    );
  }

  int _amountInTheBasket(String plu) {
    final items = checkoutItems.where(
      (listItem) => plu == listItem.plu,
    );

    return items.fold(
      0,
      (previousValue, element) => previousValue + element.quantity!,
    );
  }
}
