

import 'package:alpaca/alpaca.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'store_information_item.dart';

class StoreInformation extends StatelessWidget {
  const StoreInformation({
    Key? key,
    required this.phoneNumer,
    required this.address,
  }) : super(key: key);

  final String phoneNumer;
  final String address;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 18,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Store information',
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                        color: AlpacaColor.darkNavyColor,
                      ),
                ),
                SvgPicture.asset(
                        'assets/icons/chevron-left.svg',
                        color: AlpacaColor.lightGreyColor100,
                        height: 24,
                        width: 24,
                ),
              ],
            ),
          ),
          const StoreInformationItem(
            icon: 'assets/icons/clock-opening-times.svg',
            title: 'Opening times',
            description: '11:00-22:00',
          ),
          StoreInformationItem(
            icon: 'assets/icons/phone-store-address.svg',
            title: 'Contact number',
            description: phoneNumer,
          ),
          StoreInformationItem(
            icon: 'assets/icons/location-store-address.svg',
            title: 'Store address',
            description: address,
          ),
        ],
      ),
    );
  }
}
