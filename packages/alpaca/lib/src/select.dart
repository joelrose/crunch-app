import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'bounceable.dart';
import 'color.dart';

class AlpacaSelect extends StatelessWidget {
  const AlpacaSelect({
    Key? key,
    required this.onDecrease,
    required this.onIncrease,
    required this.amount,
    required this.textBoxHorizontalPadding,
    required this.textStyle,
  }) : super(key: key);

  final void Function() onDecrease;
  final void Function() onIncrease;
  final String amount;

  final double textBoxHorizontalPadding;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildSelectButton(
          onTap: onDecrease,
          imagePath: 'assets/icons/minus.svg',
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: textBoxHorizontalPadding,
          ),
          child: Text(
            amount,
            style: textStyle,
            textAlign: TextAlign.center,
          ),
        ),
        _buildSelectButton(
          onTap: onIncrease,
          imagePath: 'assets/icons/plus.svg',
        ),
      ],
    );
  }

  Widget _buildSelectButton({
    required void Function() onTap,
    required String imagePath,
  }) {
    return Bounceable(
      onTap: () {
        HapticFeedback.mediumImpact();
        onTap();
      },
      child: Container(
        alignment: Alignment.center,
        width: 25,
        height: 25,
        decoration: BoxDecoration(
          border: Border.all(
            width: 0.5,
            color: AlpacaColor.greyColor,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: SvgPicture.asset(
          imagePath,
          color: AlpacaColor.darkGreyColor,
          width: 15,
        ),
      ),
    );
  }
}
