import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:stretchy_header/stretchy_header.dart';

class AlpacaStretchyHeader extends StatelessWidget {
  const AlpacaStretchyHeader({
    Key? key,
    required this.child,
    required this.image,
  }) : super(key: key);

  final Widget child;
  final String image;

  @override
  Widget build(BuildContext context) {
    return StretchyHeader.singleChild(
      headerData: HeaderData(
        headerHeight: 200,
        header: Image.network(
          image,
          fit: BoxFit.cover,
        ),
        blurContent: false,
        overlay: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 18,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                color: AlpacaColor.white100Color,
                icon: const Icon(
                  Icons.arrow_back_ios,
                ),
                padding: const EdgeInsets.all(10),
                alignment: Alignment.topLeft,
              ),
            ],
          ),
        ),
      ),
      child: child,
    );
  }
}
