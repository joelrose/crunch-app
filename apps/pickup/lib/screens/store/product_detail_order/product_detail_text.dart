import 'package:flutter/material.dart';

class ProductBasicDetails extends StatelessWidget {
  const ProductBasicDetails({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .headline2!
                .merge(const TextStyle(fontSize: 22)),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'Example description! Should be changed when basic details are available',
            style: Theme.of(context).textTheme.subtitle2,
          )
        ],
      ),
    );
  }
}
