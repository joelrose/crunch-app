import 'package:alpaca/global.dart';
import 'package:alpaca/shared/page_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GetSupport extends StatelessWidget {
  const GetSupport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      backgroundColor: AlpacaColor.white100Color,
      statusBarStyle: SystemUiOverlayStyle.dark,
      child: Text(
        'Support',
        style: Theme.of(context)
            .textTheme
            .headline1!
            .merge(const TextStyle(color: AlpacaColor.darkGreyColor)),
      ),
    );
  }
}
