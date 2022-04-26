import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickup/screens/search_bar/cubit/search_bar_cubit.dart';
import 'package:pickup/screens/search_bar/widgets/active_search_widget.dart';
import 'package:pickup/screens/search_bar/widgets/start_searching_widget.dart';

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
          child: Builder(
            builder: (context) {
              if (state.searchHistory.isEmpty && state.query.isEmpty) {
                return const NotActiveSearchWidget();
              } else {
                return const ActiveSearchWidget();
              }
            },
          ),
        ),
      ),
    );
  }
}
