import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pickup/screens/discover/discover.dart';
import 'package:pickup/screens/home/home.dart';
import 'package:pickup/screens/orders/orders.dart';
import 'package:pickup/shared/construction.dart';

class HomeView extends StatelessWidget {
  static final bottomNavigationBar = _bottomNavigationBar();
  static final highlitedBottomNavigationBar = _bottomNavigationBar(
    highlited: true,
  );

  @override
  Widget build(BuildContext context) {
    final selectedTab = context.select((HomeCubit cubit) => cubit.state.tab);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AlpacaColor.white100Color,
        body: SafeArea(
          child: IndexedStack(
            index: selectedTab.index,
            children: const [
              DiscoverPage(),
              OrdersPage(),
              ConstructionScreen(title: 'Vouchers'),
              ConstructionScreen(title: 'Friends'),
            ],
          ),
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

  static List<BottomNavigationBarItem> _bottomNavigationBar({
    bool highlited = false,
  }) {
    final color = highlited ? AlpacaColor.primary100 : AlpacaColor.greyColor;
    return [
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          'assets/icons/compass.svg',
          color: color,
        ),
        label: 'Discover',
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          'assets/icons/collection.svg',
          color: color,
        ),
        label: 'Orders',
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          'assets/icons/receipt-tax.svg',
          color: color,
        ),
        label: 'Vouchers',
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          'assets/icons/users.svg',
          color: color,
        ),
        label: 'Friends',
      ),
    ];
  }
}
