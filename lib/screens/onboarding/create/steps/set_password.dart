import 'package:alpaca/global.dart';
import 'package:alpaca/shared/buttons.dart';
import 'package:flutter/material.dart';

class StepSetPassword extends StatefulWidget {
  const StepSetPassword({Key? key, required this.onFinish}) : super(key: key);

  final void Function() onFinish;

  @override
  _StepSetPasswordState createState() => _StepSetPasswordState();
}

class _StepSetPasswordState extends State<StepSetPassword> {
  late TextEditingController _passwordController;
  late TextEditingController _passwordRepeatController;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _passwordRepeatController = TextEditingController();
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
            'We need a little more information from you? Please set your password!',
            style: theme.subtitle1!.merge(
              const TextStyle(
                color: AlpacaColor.blackColor,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: AlpacaTextField(
            hintText: 'Password',
            textController: _passwordController,
            obscureText: true,
            textInputType: TextInputType.visiblePassword,
            validator: (value) {
              if (value!.isEmpty || value.length < 3) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: AlpacaTextField(
            hintText: 'Repeat password',
            textController: _passwordRepeatController,
            obscureText: true,
            textInputType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
            validator: (value) {
              if (value!.isEmpty && value.length < 8) {
                return 'Please enter a valid password';
              }
              return null;
            },
          ),
        ),
        Expanded(
          child: Container(),
        ),
        ActionButton(
          buttonText: 'Continue',
          onPressed: () {
            widget.onFinish();
          },
        ),
      ],
    );
  }
}
