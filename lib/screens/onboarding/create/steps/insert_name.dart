import 'package:alpaca/global.dart';
import 'package:alpaca/services/database_service.dart';
import 'package:alpaca/services/service_locator.dart';
import 'package:alpaca/shared/buttons.dart';
import 'package:flutter/material.dart';

class StepInsertName extends StatefulWidget {
  const StepInsertName({Key? key, required this.onFinish}) : super(key: key);

  final void Function() onFinish;

  @override
  _StepInsertNameState createState() => _StepInsertNameState();
}

class _StepInsertNameState extends State<StepInsertName> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Form(
        key: _formKey,
        child: Column(
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: AlpacaTextField(
                hintText: 'First name',
                textController: _firstNameController,
                validator: (value) {
                  if (value!.isEmpty || value.length < 3) {
                    return 'Please enter a valid name';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: AlpacaTextField(
                hintText: 'Last name',
                textController: _lastNameController,
                textInputAction: TextInputAction.done,
                validator: (value) {
                  if (value!.isEmpty || value.length < 3) {
                    return 'Please enter a valid name';
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
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final data = {
                    'lastActivity': DateTime.now(),
                    'firstName': _firstNameController.text,
                    'lastName': _lastNameController.text,
                  };

                  await locator<DatabaseService>().saveUserData(data);

                  widget.onFinish();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
