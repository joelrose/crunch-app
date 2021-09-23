import 'package:alpaca/global.dart';
import 'package:alpaca/shared/page_wrapper.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      backgroundColor: AlpacaColor.white100Color,
      child: SingleChildScrollView(
        child: Column(
          children: const [
            Text('Profile'),
          ],
        ),
      ),
    );
  }
}
