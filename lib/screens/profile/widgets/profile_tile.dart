import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    Key? key,
    required this.title,
    this.imagePath = 'assets/icons/user.svg',
    this.suffixWidget = const Icon(
      Icons.navigate_next,
      size: 30,
      color: AlpacaColor.lightGreyColor100,
    ),
    this.onPressed,
  }) : super(key: key);

  final String title;
  final String imagePath;
  final Widget suffixWidget;

  final void Function()? onPressed;
 
  @override
  Widget build(BuildContext context) {
    return SizedBox(
     height: 61,
      child: Column(
        children: [
          const AlpacaDivider(),
          TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              primary: AlpacaColor.primary100,
            ),
            onPressed: onPressed,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: _buildTileContent(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTileContent(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              imagePath,
              color: AlpacaColor.lightGreyColor100,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 16,
                          color: AlpacaColor.darkNavyColor,
                        ),
                  ),
                ),
              ],
            ),
          ],
        ),
        suffixWidget
      ],
    );
  }
}
