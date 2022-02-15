import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/svg.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:pickup/screens/home/base/discover.dart';
import 'package:pickup/screens/home/cubit/home_cubit.dart';
import 'package:pickup/services/auth_service.dart';
import 'package:pickup/services/service_locator.dart';
import 'package:pickup/shared/construction.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const route = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () => initOneSignal());
  }

  Future<void> initOneSignal() async {
    OneSignal.shared.setAppId(dotenv.get('ONESIGNAL_APPID'));

    OneSignal.shared
        .promptUserForPushNotificationPermission()
        .then((accepted) async {
      final auth = locator<AuthService>();
      final user = await auth.getUser;
      if (user != null) {
        OneSignal.shared.setExternalUserId(user.uid);

        if (user.email != null) {
          OneSignal.shared.setEmail(email: user.email!);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: HomeView(),
    );
  }
}

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
        body: IndexedStack(
          index: selectedTab.index,
          children: const [
            SafeArea(child: DiscoverScreen()),
            SafeArea(child: ConstructionScreen(title: 'Orders')),
            SafeArea(child: ConstructionScreen(title: 'Vouchers')),
            SafeArea(child: ConstructionScreen(title: 'Friends')),
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

  static List<BottomNavigationBarItem> _bottomNavigationBar(
      {bool highlited = false}) {
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
