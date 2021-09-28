import 'package:alpaca/sanity/model.dart';
import 'package:flutter/material.dart';

class StoreMenueList extends StatelessWidget {
  const StoreMenueList({
    Key? key,
    required this.menueCategories,
  }) : super(key: key);

  final List<RestaurantMenueCategoryModel> menueCategories;

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
                        color: Color(0xff2b2d42),
                        fontSize: 18,
                        fontFamily: "Inter",
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
          itemCount: menueCategories.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, i) {
            final category = menueCategories[i];
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
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 25,
                      ),
                      title: Text(
                        item.title.english,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                      ),
                      subtitle: Text(
                        '${item.price} €',
                        style: Theme.of(context).textTheme.bodyText1,
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
