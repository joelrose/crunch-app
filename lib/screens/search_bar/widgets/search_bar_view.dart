import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:pickup/l10n/l10n.dart';
import 'package:pickup/screens/discover/widgets/widgets.dart';
import 'package:pickup/screens/search_bar/cubit/search_bar_cubit.dart';
import 'package:pickup/screens/search_bar/widgets/widgets.dart';

class SearchBarView extends StatefulWidget {
  const SearchBarView({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  State<SearchBarView> createState() => _SearchBarViewState();
}

class _SearchBarViewState extends State<SearchBarView> {
  final controller = FloatingSearchBarController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isAppBarVisible =
        context.select((SearchBarCubit cubit) => cubit.state.isAppBarVisible);

    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverAppBar(
          toolbarHeight: isAppBarVisible ? 0 : 50,
          backgroundColor: AlpacaColor.white100Color,
          flexibleSpace: Wrap(children: const [DiscoverAppBar()]),
        ),
      ],
      body: Row(
        children: [
          Flexible(
            child: FloatingSearchBar(
              margins: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              insets: const EdgeInsets.symmetric(horizontal: 1),
              borderRadius: BorderRadius.circular(8),
              backgroundColor: AlpacaColor.lightGreyColor80,
              backdropColor: AlpacaColor.white100Color,
              shadowColor: Colors.transparent,
              iconColor: AlpacaColor.darkGreyColor,
              queryStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w300,
                color: AlpacaColor.darkNavyColor,
              ),
              controller: controller,
              transition: SlideFadeFloatingSearchBarTransition(),
              hint: context.l10n.searchBarHint,
              hintStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w300,
                color: AlpacaColor.greyColor80,
              ),
              automaticallyImplyBackButton: false,
              padding: const EdgeInsets.symmetric(horizontal: 6),
              leadingActions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: SvgPicture.asset(
                    'assets/icons/search.svg',
                    color: AlpacaColor.darkGreyColor,
                  ),
                ),
              ],
              actions: [
                if (controller.query.isNotEmpty) ...[
                  FloatingSearchBarAction(
                    showIfOpened: true,
                    showIfClosed: false,
                    child: IconButton(
                      icon: SvgPicture.asset(
                        'assets/icons/close.svg',
                        color: AlpacaColor.darkGreyColor,
                      ),
                      onPressed: () {
                        controller.query = '';
                        context.read<SearchBarCubit>().clearSearch();
                      },
                    ),
                  ),
                ] else
                  FloatingSearchBarAction(
                    showIfOpened: true,
                    showIfClosed: false,
                    child: TextButton(
                      child: Text(
                        context.l10n.cancel,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              color: AlpacaColor.darkGreyColor,
                            ),
                      ),
                      onPressed: () => controller.close(),
                    ),
                  )
              ],
              onQueryChanged: context.read<SearchBarCubit>().newQuery,
              onFocusChanged: (v) =>
                  context.read<SearchBarCubit>().onFocusChanged(),
              onSubmitted: context.read<SearchBarCubit>().newQuery,
              builder: (context, transition) {
                return const SearchResultsWidget();
              },
              body: widget.child,
            ),
          ),
        ],
      ),
    );
  }
}
