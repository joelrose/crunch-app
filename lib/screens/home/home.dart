import 'package:alpaca/global.dart';
import 'package:alpaca/screens/home/base/discover.dart';
import 'package:alpaca/screens/home/base/favorites.dart';
import 'package:alpaca/screens/home/base/vouchers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    DiscoverScreen(),
    VoucherScreen(),
    FavoritesScreen(),
    VoucherScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AlpacaColor.white100Color,
        body: SafeArea(
          child: IndexedStack(
            index: _selectedIndex,
            children: _pages,
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AlpacaColor.primary100,
          unselectedItemColor: AlpacaColor.greyColor,
          currentIndex: _selectedIndex, //New
          onTap: _onItemTapped,
          showUnselectedLabels: true,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/compass.svg'),
              label: 'Discover',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/voucher.svg',
              ),
              label: 'Vouchers',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/star.svg'),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/search.svg'),
              label: 'Search',
            ),
          ],
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
