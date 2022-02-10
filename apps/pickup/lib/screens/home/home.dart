import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pickup/screens/home/base/discover.dart';
import 'package:pickup/screens/home/base/favorites.dart';
import 'package:pickup/screens/home/base/orders.dart';
import 'package:pickup/screens/home/base/vouchers.dart';

final bottonNavItems = <BottomNavigationBarItem>[
  BottomNavigationBarItem(
    icon: SvgPicture.asset('assets/icons/compass.svg'),
    label: 'Discover',
  ),
  BottomNavigationBarItem(
    icon: SvgPicture.asset('assets/icons/receipt-tax.svg'),
    label: 'Vouchers',
  ),
  BottomNavigationBarItem(
    icon: SvgPicture.asset('assets/icons/collection.svg'),
    label: 'Orders',
  ),
  BottomNavigationBarItem(
    icon: SvgPicture.asset('assets/icons/star.svg'),
    label: 'Favorites',
  ),
];

final bottonNavHighlitedItems = <BottomNavigationBarItem>[
  BottomNavigationBarItem(
    icon: SvgPicture.asset(
      'assets/icons/compass.svg',
      color: AlpacaColor.primary100,
    ),
    label: 'Discover',
  ),
  BottomNavigationBarItem(
    icon: SvgPicture.asset(
      'assets/icons/receipt-tax.svg',
      color: AlpacaColor.primary100,
    ),
    label: 'Vouchers',
  ),
  BottomNavigationBarItem(
    icon: SvgPicture.asset(
      'assets/icons/collection.svg',
      color: AlpacaColor.primary100,
    ),
    label: 'Orders',
  ),
  BottomNavigationBarItem(
    icon: SvgPicture.asset(
      'assets/icons/star.svg',
      color: AlpacaColor.primary100,
    ),
    label: 'Favorites',
  ),
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const route = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    SafeArea(child: DiscoverScreen()),
    SafeArea(child: VoucherScreen()),
    SafeArea(child: OrdersScreen(),),
    SafeArea(child: FavoritesScreen()),
  ];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AlpacaColor.white100Color,
        body: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AlpacaColor.primary100,
          unselectedItemColor: AlpacaColor.greyColor,
          backgroundColor: AlpacaColor.white100Color,
          unselectedFontSize: 14.0,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          showUnselectedLabels: true,
          items: bottonNavItems.asMap().entries.map((entry) {
            final int index = entry.key;
            final BottomNavigationBarItem value = entry.value;
            return index == _selectedIndex
                ? bottonNavHighlitedItems[index]
                : value;
          }).toList(),
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
