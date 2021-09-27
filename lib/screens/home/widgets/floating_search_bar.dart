import 'package:alpaca/global.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:alpaca/screens/home/base/discover.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  static const historyLenght = 5;

  final List<String> _searchHistory = ['Flutter', 'Future'];

  List<String>? filteredSearchHistory;

  String? selectedTerm;

  bool isSearchBarVisible = false;

  List<String> filterSearchTerms({
    @required String filter = '',
  }) {
    if (filter != '' && filter.isNotEmpty) {
      return _searchHistory.reversed
          .where((term) => term.startsWith(filter))
          .toList();
    } else {
      return _searchHistory.reversed.toList();
    }
  }

  void addSearchTerm(String term) {
    if (_searchHistory.contains(term)) {
      putSearchTermFirst(term);
      return;
    }

    _searchHistory.add(term);
    if (_searchHistory.length > historyLenght) {
      _searchHistory.removeRange(0, _searchHistory.length - historyLenght);
    }

    filteredSearchHistory = filterSearchTerms(filter: '');
  }

  void deleteSearchTerm(String term) {
    _searchHistory.removeWhere((t) => t == term);
    filteredSearchHistory = filterSearchTerms(filter: '');
  }

  void putSearchTermFirst(String term) {
    deleteSearchTerm(term);
    addSearchTerm(term);
  }

  late FloatingSearchBarController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = FloatingSearchBarController();
    filteredSearchHistory = filterSearchTerms(filter: '');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          height: isSearchBarVisible ? 0 : 60,
          child: Wrap(children: const [DiscoverNavBar()]),
        ),
        Expanded(
          child: FloatingSearchBar(
            backgroundColor: AlpacaColor.lightGreyColor80,
            backdropColor: AlpacaColor.white100Color,
            shadowColor: Colors.transparent,
            iconColor: AlpacaColor.darkGreyColor,
            queryStyle: const TextStyle(color: AlpacaColor.blackColor),
            scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
            controller: controller,
            transition: CircularFloatingSearchBarTransition(),
            hint: 'Search for food, stores or tags...',
            automaticallyImplyBackButton: false,
            leadingActions: [
              FloatingSearchBarAction.searchToClear(),
            ],
            actions: [
              // FloatingSearchBarAction.back(),
              // FloatingSearchBarAction.icon(
              //   icon: Icons.close,
              //   onTap: () {
              //     controller.clear();
              //   },
              //   showIfClosed: false,
              //   showIfOpened: true,
              // ),
              FloatingSearchBarAction(
                showIfOpened: true,
                showIfClosed: false,
                child: TextButton(
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: AlpacaColor.darkGreyColor),
                  ),
                  onPressed: () {
                    controller.close();
                  },
                ),
              )
            ],
            onQueryChanged: (query) {
              setState(() {
                filteredSearchHistory = filterSearchTerms(filter: query);
              });
            },
            onFocusChanged: (v) {
              setState(() {
                isSearchBarVisible = !isSearchBarVisible;
              });
            },
            onSubmitted: (query) {
              setState(() {
                addSearchTerm(query);
                selectedTerm = query;
              });
              controller.close();
            },
            builder: (context, transition) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Material(
                  color: AlpacaColor.white100Color,
                  child: Builder(
                    builder: (context) {
                      if (filteredSearchHistory!.isEmpty &&
                          controller.query.isEmpty) {
                        return Container(
                          height: 56,
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: Text(
                            'Start searching',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        );
                      } else if (filteredSearchHistory!.isEmpty) {
                        return ListTile(
                          title: Text(controller.query),
                          onTap: () {
                            setState(() {
                              addSearchTerm(controller.query);
                              selectedTerm = controller.query;
                            });
                            controller.close();
                          },
                        );
                      } else {
                        return Container();
                        // return Column(
                        //   mainAxisSize: MainAxisSize.min,
                        //   children: filteredSearchHistory.map(
                        //     (term) => ListTile(
                        //     title: Text(
                        //       term,
                        //       maxLines: 1,
                        //       overflow: TextOverflow.ellipsis,
                        //       ),
                        //     ),
                        //   ),
                        // );
                      }
                    },
                  ),
                ),
              );
            },
            body: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: const [
                  DiscoverBody(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
