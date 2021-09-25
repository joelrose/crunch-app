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

  FloatingSearchBarController? controller;

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
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const DiscoverNavBar(),
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
            leadingActions: const [
              Icon(
                Icons.search,
              ),
            ],
            actions: [
              FloatingSearchBarAction.icon(
                icon: Icons.close,
                onTap: () {
                  controller!.clear();
                },
                showIfClosed: false,
                showIfOpened: true,
              ),
            ],
            onQueryChanged: (query) {
              setState(() {
                filteredSearchHistory = filterSearchTerms(filter: query);
              });
            },
            onSubmitted: (query) {
              setState(() {
                addSearchTerm(query);
                selectedTerm = query;
              });
              controller?.close();
            },
            builder: (context, transition) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Material(
                  color: AlpacaColor.white100Color,
                  child: Container(
                    height: 200,
                    color: AlpacaColor.primary100,
                    child: const Center(
                      child: Text(
                        'Work in progress...',
                        style: TextStyle(
                          color: AlpacaColor.white100Color,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
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
