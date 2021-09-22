import 'package:alpaca/global.dart';
import 'package:alpaca/routes.dart';
import 'package:alpaca/services/auth_service.dart';
import 'package:alpaca/services/service_locator.dart';
import 'package:alpaca/shared/buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthService auth = locator<AuthService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AlpacaColor.white100Color,
      body: SafeArea(
        child: Column(
          children: [
            const HomeMain(),
            ActionButton(
              buttonText: 'Logout',
              onPressed: () async {
                await auth.signOut();
                Navigator.of(context).pushNamedAndRemoveUntil(
                  onboardingWelcomeRoute,
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AlpacaColor.primary100,
        unselectedItemColor: AlpacaColor.greyColor,
        showUnselectedLabels: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.compass_calibration),
            label: 'Discover',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: 'Vouchers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
        ],
      ),
    );
  }
}

class HomeMain extends StatelessWidget {
  const HomeMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 113,
          margin: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: [
              Row(
                children: [
                  SvgPicture.asset('assets/logo/crunch-logo.svg',
                      width: 100, color: AlpacaColor.primary100),
                  const Spacer(),
                  Container(
                    height: 36,
                    width: 36,
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border:
                          Border.all(color: AlpacaColor.primary100, width: 3),
                    ),
                  )
                ],
              ),
              Container(
                  width: double.infinity,
                  height: 44,
                  margin: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    color: const Color(0xffF5F5F6),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.search,
                          color: AlpacaColor.darkGreyColor,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 11),
                          child: const Text(
                            'Search for food, stores or tags',
                            style: TextStyle(color: AlpacaColor.darkGreyColor),
                          ),
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ),
        const Divider(
          height: 1,
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(18, 14, 18, 0),
          width: double.infinity,
          height: 123,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AlpacaColor.primary100,
          ),
          child: Container(
            margin:
                const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Not sure what \nto grab?',
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                          color: AlpacaColor.white100Color,
                          fontSize: 22,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      'Lets find something together.',
                      style: TextStyle(
                        color: AlpacaColor.white100Color,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
                Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(45),
                    color: AlpacaColor.white100Color,
                  ),
                  child: const Icon(
                    Icons.arrow_forward_rounded,
                    size: 19,
                  ),
                )
              ],
            ),
          ),
        ),
        Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 18),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Favourite stores',
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: AlpacaColor.darkNavyColor)),
                        Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: AlpacaColor.greyColor),
                                borderRadius: BorderRadius.circular(4)),
                            child: const Center(
                              child: Text(
                                'View all',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: AlpacaColor.darkNavyColor),
                              ),
                            ))
                      ],
                    ),
                  ),
                  Container(height: 18),
                  const LeftToRightScrollingList(),
                  const LeftToRightScrollingList(),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}

class LeftToRightScrollingList extends StatelessWidget {
  const LeftToRightScrollingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(18, 0, 0, 0),
      height: 194,
      child: ListView.separated(
        clipBehavior: Clip.none,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            height: 194,
            width: 235,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AlpacaColor.white100Color,
              boxShadow: [
                BoxShadow(
                  color: AlpacaColor.blackColor.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(3, 3),
                )
              ],
            ),
            child: Column(
              children: [
                Container(
                    width: double.infinity,
                    height: 123,
                    decoration: const BoxDecoration(
                      color: AlpacaColor.greyColor,
                    ))
              ],
            ),
          );
        },
      ),
    );
  }
}
