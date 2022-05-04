import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickup/l10n/l10n.dart';
import 'package:pickup/screens/search_bar/cubit/search_bar_cubit.dart';
import 'package:pickup/screens/search_bar/widgets/matching_restaurants_widget.dart';

class SearchResultsWidget extends StatelessWidget {
  const SearchResultsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.select((SearchBarCubit cubit) => cubit.state);

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Material(
          color: AlpacaColor.white100Color,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (state.query.isNotEmpty && state.stores.isNotEmpty)
                const MatchingRestaurantsWidget(),
              if (state.query.isNotEmpty && state.stores.isEmpty)
                Text(
                  context.l10n.noRestaurantsFound,
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        color: AlpacaColor.darkGreyColor,
                      ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
