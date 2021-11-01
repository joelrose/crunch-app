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
            top: 60.0,
            bottom: 10,
          ),
          child: Text(
            title,
            style: Theme.of(context).textTheme.headline1!.copyWith(
                  fontSize: 30,
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
