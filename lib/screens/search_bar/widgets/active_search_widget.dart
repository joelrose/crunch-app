import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickup/l10n/l10n.dart';
import 'package:pickup/screens/search_bar/cubit/search_bar_cubit.dart';
import 'package:pickup/screens/search_bar/widgets/matching_restaurants_widget.dart';
import 'package:pickup/screens/search_bar/widgets/recent_search_widget.dart';

class ActiveSearchWidget extends StatelessWidget {
  const ActiveSearchWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.select((SearchBarCubit cubit) => cubit.state);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (state.isRecentSearchVisible) const RecentSearchWidget(),
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
    );
  }
}
