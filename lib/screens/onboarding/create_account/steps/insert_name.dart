import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_repository/hermes_repository.dart';
import 'package:pickup/l10n/l10n.dart';
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
            context.l10n.onboardingNameTitle,
            style: theme.headline1!.copyWith(
              color: AlpacaColor.blackColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20, top: 10),
            child: Text(
              context.l10n.onboardingNameDescription,
              style: theme.headline5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: AlpacaTextField(
              key: const Key('onboarding_firstname_textfield'),
              hintText: context.l10n.firstName,
              textController: _firstNameController,
              textInputAction: TextInputAction.done,
              validator: (value) {
                if (value!.isEmpty || value.length < 3) {
                  return context.l10n.onboardingNameNotValid;
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: AlpacaTextField(
              key: const Key('onboarding_lastname_textfield'),
              hintText: context.l10n.lastName,
              textController: _lastNameController,
              textInputAction: TextInputAction.done,
              validator: (value) {
                if (value!.isEmpty || value.length < 3) {
                  return context.l10n.onboardingNameNotValid;
                }
                return null;
              },
            ),
          ),
          Expanded(child: Container()),
          ActionButton(
            buttonText: context.l10n.next,
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                final hermesRepository = context.read<HermesRepository>();

                // TODO: validate response
                final response =
                    await LoadingUtils.asyncLoading<Response<bool>>(
                  hermesRepository.client.apiUsersPost(
                    body: CreateUserRequestDto(
                      firstName: _firstNameController.text,
                      lastName: _lastNameController.text,
                    ),
                  ),
                );

                if (response.isSuccessful) {
                  widget.whichStepInCreateAccount();
                } else {
                  final snackBar = SnackBar(
                    content: Text(context.l10n.unknownAPIError),
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
