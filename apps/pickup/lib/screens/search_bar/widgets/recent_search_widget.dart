import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class RecentSearchWidget extends StatelessWidget {
  const RecentSearchWidget({
    Key? key,
    required this.controller,
    required this.filteredSearchHistory,
    required this.deleteSearchTerm,
  }) : super(key: key);

  final FloatingSearchBarController controller;
  final List<String> filteredSearchHistory;
  final Function deleteSearchTerm;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Text(
            'Recent searches',
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  color: AlpacaColor.darkGreyColor,
                ),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: filteredSearchHistory
              .where(
                (recentSearch) =>
                    recentSearch.toLowerCase() !=
                    controller.query.toLowerCase(),
              )
              .map(
                (recentSearch) => Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        onTap: () {
                          controller.query = recentSearch;
                        },
                        title: Text(
                          recentSearch,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    color: AlpacaColor.darkNavyColor,
                                  ),
                        ),
                        trailing: IconButton(
                          padding: EdgeInsets.zero,
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            deleteSearchTerm(
                              term: recentSearch,
                            );
                          },
                        ),
                      ),
                      const Divider(
                        height: 0,
                      )
                    ],
                  ),
                ),
              )
              .toList(),
        )
      ],
    );
  }
}
