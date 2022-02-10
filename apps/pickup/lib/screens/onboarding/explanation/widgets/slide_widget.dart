import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';

class SlideWidget extends StatelessWidget {
  const SlideWidget({
    required this.title,
    required this.description,
    required this.image,
  });

  final String title;
  final String description;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          image,
          fit: BoxFit.cover,
          height: MediaQuery.of(context).size.height * 0.38,
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(
            top: 60,
            bottom: 10,
          ),
          child: Text(
            title,
            style: Theme.of(context).textTheme.headline1!.copyWith(
                  color: AlpacaColor.white100Color,
                ),
            textAlign: TextAlign.left,
          ),
        ),
        Text(
          description,
          style: Theme.of(context).textTheme.subtitle1,
          textAlign: TextAlign.left,
        ),
      ],
    );
  }
}
