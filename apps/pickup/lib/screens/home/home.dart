import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/svg.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:pickup/screens/home/base/discover.dart';
import 'package:pickup/shared/construction.dart';

final bottonNavItems = <BottomNavigationBarItem>[
  BottomNavigationBarItem(
    icon: SvgPicture.asset('assets/icons/compass.svg'),
    label: 'Discover',
  ),
  BottomNavigationBarItem(
    icon: SvgPicture.asset('assets/icons/collection.svg'),
    label: 'Orders',
  ),
  BottomNavigationBarItem(
    icon: SvgPicture.asset('assets/icons/receipt-tax.svg'),
    label: 'Vouchers',
  ),
  BottomNavigationBarItem(
    icon: SvgPicture.asset('assets/icons/users.svg'),
    label: 'Friends',
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
      'assets/icons/collection.svg',
      color: AlpacaColor.primary100,
    ),
    label: 'Orders',
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
      'assets/icons/users.svg',
      color: AlpacaColor.primary100,
    ),
    label: 'Friends',
  ),
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const route = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(seconds: 2),
      () {
        //Remove this method to stop OneSignal Debugging
        // OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

        OneSignal.shared.setAppId(dotenv.get('ONESIGNAL_APPID'));

        OneSignal.shared
            .promptUserForPushNotificationPermission()
            .then((accepted) {
          print('Accepted permission: $accepted');
        });
      },
    );
  }

  int _selectedIndex = 0;

  static final List<Widget> _pages = [
    const SafeArea(child: DiscoverScreen()),
    const SafeArea(child: ConstructionScreen(title: 'Orders')),
    const SafeArea(child: ConstructionScreen(title: 'Vouchers')),
    const SafeArea(child: ConstructionScreen(title: 'Friends')),
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
