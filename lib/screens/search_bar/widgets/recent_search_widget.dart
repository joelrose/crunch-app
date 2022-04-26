import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickup/screens/search_bar/cubit/search_bar_cubit.dart';

class RecentSearchWidget extends StatelessWidget {
  const RecentSearchWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.select((SearchBarCubit cubit) => cubit.state);

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
          children: state.searchHistory
              .where(
                (recentSearch) =>
                    recentSearch.toLowerCase() != state.query.toLowerCase(),
              )
              .map(
                (recentSearch) => Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        onTap: () {
                          //controller.query = recentSearch;
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
                            /*deleteSearchTerm(
                              term: recentSearch,
                            );*/
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
