import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';

class OnboardingAccountHeader extends StatelessWidget {
  const OnboardingAccountHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Stack(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 30,
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => {Navigator.of(context).pop()},
                  child: const Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                    color: AlpacaColor.white100Color,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: -70,
            top: -15,
            height: MediaQuery.of(context).size.height * 0.55,
            child: Transform.rotate(
              angle: -45,
              child: Image.asset(
                'assets/onboarding/create-account-3D.png',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
