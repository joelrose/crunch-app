import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickup/screens/discover/cubit/discover_cubit.dart';
import 'package:pickup/screens/search_bar/cubit/search_bar_cubit.dart';
import 'package:pickup/screens/search_bar/widgets/search_bar_view.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBarCubit([]),
      child: BlocListener<DiscoverCubit, DiscoverState>(
        listener: (context, state) {
          if (state.status.isSuccess) {
            context.read<SearchBarCubit>().setStores(state.stores);
          }
        },
        child: SearchBarView(
          child: child,
        ),
      ),
    );
  }
}
