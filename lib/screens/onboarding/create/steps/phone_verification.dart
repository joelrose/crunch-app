import 'package:alpaca/global.dart';
import 'package:alpaca/shared/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';

class StepPhoneVerification extends StatefulWidget {
  const StepPhoneVerification({Key? key}) : super(key: key);

  @override
  _StepPhoneVerificationState createState() => _StepPhoneVerificationState();
}

class _StepPhoneVerificationState extends State<StepPhoneVerification> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Column(
      children: [
        Text(
          "We've sent a verification Code to",
          style: theme.headline1!.merge(
            const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: AlpacaColor.blackColor,
              height: 1.4,
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            '+49 174 3645092',
            style: theme.headline1!.merge(
              const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: AlpacaColor.primary100,
                height: 1.4,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 40, top: 10),
          child: Text(
            'Please check your messages and enter the code in the boxes below.',
            style: theme.subtitle1!.merge(
              const TextStyle(
                color: AlpacaColor.blackColor,
              ),
            ),
          ),
        ),
        VerificationCode(
          textStyle:
              const TextStyle(fontSize: 20.0, color: AlpacaColor.blackColor),
          underlineColor: AlpacaColor.blackColor,
          length: 6,
          onCompleted: (String value) {
            setState(() {});
          },
          onEditing: (bool value) {
            setState(() {});
          },
        ),
        Expanded(
          child: Container(),
        ),
        ActionButton(
          buttonText: 'Continue',
          onPressed: () {},
        ),
      ],
    );
  }
}
