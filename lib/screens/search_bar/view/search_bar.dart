import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:pickup/screens/discover/cubit/discover_cubit.dart';
import 'package:pickup/screens/search_bar/cubit/search_bar_cubit.dart';
import 'package:pickup/screens/search_bar/widgets/search_bar_view.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key, required this.child}) : super(key: key);

  final Widget child;
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final controller = FloatingSearchBarController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiscoverCubit, DiscoverState>(
      builder: (context, state) {
        if (state.status.isSuccess) {
          return BlocProvider(
            key: const ValueKey('loaded_search_bar'),
            lazy: false,
            create: (context) => SearchBarCubit(state.stores),
            child: SearchBarView(
              controller: controller,
              child: widget.child,
            ),
          );
        }

        return BlocProvider(
          key: const ValueKey('unloaded_search_bar'),
          create: (context) => SearchBarCubit([]),
          child: BlocListener<DiscoverCubit, DiscoverState>(
            listener: (context, state) {
              if (state.status.isSuccess) {
                context.read<SearchBarCubit>().initialStores = state.stores;
              }
            },
            child: SearchBarView(
              controller: controller,
              child: widget.child,
            ),
          ),
        );
      },
    );
  }
}
