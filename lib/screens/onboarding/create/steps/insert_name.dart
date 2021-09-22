import 'package:alpaca/global.dart';
import 'package:alpaca/shared/buttons.dart';
import 'package:flutter/material.dart';

class StepInsertName extends StatefulWidget {
  const StepInsertName({Key? key}) : super(key: key);

  @override
  _StepInsertNameState createState() => _StepInsertNameState();
}

class _StepInsertNameState extends State<StepInsertName> {
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Woo, you're not a robot!",
          style: theme.headline1!.merge(
            const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28,
              color: AlpacaColor.blackColor,
              height: 1.4,
              letterSpacing: -0.24,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 40, top: 10),
          child: Text(
            'We need a little more information from you? What can we call you?',
            style: theme.subtitle1!.merge(
              const TextStyle(
                color: AlpacaColor.blackColor,
              ),
            ),
          ),
        ),
        TextField(
          // controller: _textController,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.phone,
          autocorrect: false,
          cursorColor: AlpacaColor.blackColor,
          style: const TextStyle(
            color: AlpacaColor.blackColor,
          ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15.0,
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: AlpacaColor.lightGreyColor80,
              ),
            ),
            fillColor: AlpacaColor.lightGreyColor80,
            hintText: 'First name',
            filled: true,
            hintStyle: const TextStyle(
              color: AlpacaColor.lightGreyColor100,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AlpacaColor.lightGreyColor80,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AlpacaColor.lightGreyColor80,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: AlpacaTextField(
            hintText: 'First name',
            textController: _textController,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: AlpacaTextField(
            hintText: 'Last name',
            textController: _textController,
          ),
        ),
        Expanded(
          child: Container(),
        ),
        ActionButton(
          buttonText: 'Continue',
          onPressed: () {
            setState(() {});
          },
        ),
      ],
    );
  }
}
