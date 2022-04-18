import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pickup/l10n/l10n.dart';
import 'package:pickup/screens/discover/discover.dart';
import 'package:pickup/screens/home/home.dart';
import 'package:pickup/screens/orders/orders.dart';
import 'package:pickup/shared/construction.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bottomNavigationBar = _bottomNavigationBar(context);
    final highlitedBottomNavigationBar = _bottomNavigationBar(
      context,
      highlited: true,
    );

    final selectedTab = context.select((HomeCubit cubit) => cubit.state.tab);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AlpacaColor.white100Color,
        body: IndexedStack(
          index: selectedTab.index,
          children: [
            const SafeArea(child: DiscoverPage()),
            const SafeArea(child: OrdersPage()),
            SafeArea(
              child: ConstructionScreen(title: context.l10n.navigationVouchers),
            ),
            SafeArea(
              child: ConstructionScreen(title: context.l10n.navigationFriends),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AlpacaColor.primary100,
          unselectedItemColor: AlpacaColor.greyColor,
          backgroundColor: AlpacaColor.white100Color,
          selectedFontSize: 11,
          unselectedFontSize: 11,
          currentIndex: selectedTab.index,
          onTap: (value) => context.read<HomeCubit>().setTab(
                HomeTab.values[value],
              ),
          showUnselectedLabels: true,
          items: bottomNavigationBar.asMap().entries.map((entry) {
            final int index = entry.key;
            final BottomNavigationBarItem value = entry.value;
            return index == selectedTab.index
                ? highlitedBottomNavigationBar[index]
                : value;
          }).toList(),
        ),
      ),
    );
  }

  List<BottomNavigationBarItem> _bottomNavigationBar(
    BuildContext context, {
    bool highlited = false,
  }) {
    final color = highlited ? AlpacaColor.primary100 : AlpacaColor.greyColor;
    return [
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          'assets/icons/compass.svg',
          color: color,
        ),
        label: context.l10n.navigationDiscover,
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          'assets/icons/collection.svg',
          color: color,
        ),
        label: context.l10n.navigationOrders,
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          'assets/icons/receipt-tax.svg',
          color: color,
        ),
        label: context.l10n.navigationVouchers,
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          'assets/icons/users.svg',
          color: color,
        ),
        label: context.l10n.navigationFriends,
      ),
    ];
  }
}
