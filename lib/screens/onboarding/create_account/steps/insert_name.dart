import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:hermes_api/hermes_api.dart';
import 'package:pickup/services/hermes_service.dart';
import 'package:pickup/services/service_locator.dart';
import 'package:pickup/shared/show_async_loading.dart';

class StepInsertName extends StatefulWidget {
  const StepInsertName({Key? key, required this.whichStepInCreateAccount})
      : super(key: key);

  final void Function() whichStepInCreateAccount;

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
            padding: const EdgeInsets.only(bottom: 20, top: 10),
            child: Text(
              'We need a little more information from you? What can we call you?',
              style: theme.headline5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: AlpacaTextField(
              key: const Key('onboarding_firstname_textfield'),
              hintText: 'First name',
              textController: _firstNameController,
              textInputAction: TextInputAction.done,
              validator: (value) {
                if (value!.isEmpty || value.length < 3) {
                  return 'Please enter a valid name';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: AlpacaTextField(
              key: const Key('onboarding_lastname_textfield'),
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
          Expanded(child: Container()),
          ActionButton(
            buttonText: 'Continue',
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                final hermesService = locator<HermesService>();

                // TODO: validate response
                final response = await showAsyncLoading<Response<bool>>(
                  context,
                  hermesService.client.apiUsersPost(
                    body: CreateUserRequestDto(
                      firstName: _firstNameController.text,
                      lastName: _lastNameController.text,
                    ),
                  ),
                );

                if (response.isSuccessful) {
                  widget.whichStepInCreateAccount();
                } else {
                  const snackBar = SnackBar(
                    content: Text('Unable to connect to backend!'),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
