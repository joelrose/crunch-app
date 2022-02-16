import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';

class StepSetPassword extends StatefulWidget {
  const StepSetPassword({Key? key, required this.whichStepInCreateAccount})
      : super(key: key);

  final void Function() whichStepInCreateAccount;

  @override
  _StepSetPasswordState createState() => _StepSetPasswordState();
}

class _StepSetPasswordState extends State<StepSetPassword> {
  late TextEditingController _passwordController;
  late TextEditingController _passwordRepeatController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _passwordRepeatController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Woo, you're not a robot!",
            style: theme.headline1!.copyWith(
              color: AlpacaColor.blackColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 40, top: 10),
            child: Text(
              'We need a little more information from you? Please set your password!',
              style: theme.headline5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: AlpacaTextField(
              key: const Key('onboarding_password_textfield'),
              hintText: 'Password',
              textController: _passwordController,
              obscureText: true,
              textInputType: TextInputType.visiblePassword,
              validator: (value) {
                if (value!.isEmpty || value.length < 6) {
                  return 'Please enter a valid password';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: AlpacaTextField(
              key: const Key('onboarding_repeat_password_textfield'),
              hintText: 'Repeat password',
              textController: _passwordRepeatController,
              obscureText: true,
              textInputType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              validator: (value) {
                if (value!.isEmpty || _passwordController.text != value) {
                  return "Passwords don't match";
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
              if (_formKey.currentState!.validate()) {
                widget.whichStepInCreateAccount();
              }
            },
          ),
        ],
      ),
    );
  }
}