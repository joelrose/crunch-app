import 'package:alpaca/global.dart';
import 'package:alpaca/sanity/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class StoreMenueList extends StatefulWidget {
  const StoreMenueList({
    Key? key,
    required this.menueCategories,
    required this.onCheckoutChange,
  }) : super(key: key);

  final List<RestaurantMenueCategoryModel> menueCategories;
  final void Function(List<RestaurantMenueItemModel>) onCheckoutChange;

  @override
  State<StoreMenueList> createState() => _StoreMenueListState();
}

class _StoreMenueListState extends State<StoreMenueList> {
  late final SlidableController slidableController;
  List<RestaurantMenueItemModel> checkoutItems = [];

  void _showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(text)));
  }

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
            horizontal: 25,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Menu',
                      style: TextStyle(
                        color: AlpacaColor.darkNavyColor,
                        fontSize: 18,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
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
          itemBuilder: (context, i) {
            final category = widget.menueCategories[i];
            return Column(
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 25,
                  ),
                  title: Text(
                    category.title.english,
                    style: Theme.of(context).textTheme.headline3!.merge(
                          const TextStyle(
                            fontSize: 22,
                          ),
                        ),
                  ),
                ),
                const Divider(),
                ListView.separated(
                  itemCount: category.menueItems.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, i) {
                    final item = category.menueItems[i];
                    return Slidable(
                      key: Key(item.title.english),
                      controller: slidableController,
                      // dismissal: SlidableDismissal(
                      //   child: const SlidableBehindActionPane(),
                      //   onDismissed: (actionType) {
                      //     _showSnackBar(
                      //       context,
                      //       actionType == SlideActionType.primary
                      //           ? 'Dismiss Archive'
                      //           : 'Dimiss Delete',
                      //     );
                      //   },
                      // ),
                      actions: [
                        IconSlideAction(
                          caption: 'Delete',
                          color: Colors.red,
                          icon: Icons.delete,
                          onTap: () {
                            checkoutItems.remove(item);
                            widget.onCheckoutChange(checkoutItems);
                          },
                        ),
                      ],
                      secondaryActions: [
                        IconSlideAction(
                          caption: 'Add',
                          color: Colors.blue,
                          icon: Icons.add,
                          onTap: () {
                            checkoutItems.add(item);
                            widget.onCheckoutChange(checkoutItems);
                          },
                        ),
                      ],
                      actionPane: const SlidableBehindActionPane(),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 25,
                        ),
                        title: Text(
                          item.title.english,
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                        ),
                        subtitle: Text(
                          '${item.price} €',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                ),
                const Divider(),
              ],
            );
          },
        ),
      ],
    );
  }
}
