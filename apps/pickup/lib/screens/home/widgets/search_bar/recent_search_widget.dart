import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:pickup/screens/home/widgets/search_bar/search_bar_logic.dart';

class RecentSearchWidget extends StatelessWidget {
  const RecentSearchWidget({
    Key? key,
    required this.controller,
    required this.filteredSearchHistory,
    required this.deleteSearchTerm,
  }) : super(key: key);

  final FloatingSearchBarController controller;
  final List<String> filteredSearchHistory;
  final deleteSearchTerm;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent searches',
          style: TextStyle(
            color: AlpacaColor.darkGreyColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: filteredSearchHistory
                .where(
                  (recentSearch) => recentSearch != controller.query,
                )
                .map(
                  (recentSearch) => ListTile(
                    onTap: () {
                      controller.query = recentSearch;
                    },
                    title: Text(
                      recentSearch,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AlpacaColor.darkNavyColor,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        deleteSearchTerm(
                          term: recentSearch,
                          filter: controller.query,
                        );
                      },
                    ),
                  ),
                )
                .toList(),
          ),
        )
      ],
    );
  }
}
