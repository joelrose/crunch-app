import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_repository/hermes_repository.dart';
import 'package:loading_overlay_repository/loading_overlay_repository.dart';
import 'package:pickup/l10n/l10n.dart';
import 'package:pickup/screens/onboarding_create_account/cubit/onboarding_create_account_cubit.dart';

class StepInsertName extends StatefulWidget {
  const StepInsertName({Key? key}) : super(key: key);

  @override
  _StepInsertNameState createState() => _StepInsertNameState();
}

class _StepInsertNameState extends State<StepInsertName> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();

    super.dispose();
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
          // TODO: fix bottom button
          Container(height: 20),
          //Expanded(child: Container()),
          ActionButton(
            buttonText: context.l10n.next,
            onPressed: () async => _onSubmit(),
          ),
        ],
      ),
    );
  }

  Future<void> _onSubmit() async {
    if (_formKey.currentState!.validate()) {
      final hermesRepository = context.read<HermesRepository>();

      final loadingOverlayRepository = context.read<LoadingOverlayRepository>();

      // TODO: validate response
      final response =
          await loadingOverlayRepository.asyncLoading<Response<dynamic>>(
        hermesRepository.client.usersPost(
          request: CreateUserRequest(
            firstname: _firstNameController.text,
            lastname: _lastNameController.text,
            languageCode: 'de',
          ),
        ),
      );

      if (!mounted) return;

      if (response.isSuccessful) {
        context.read<OnboardingCreateAccountCubit>().nextStep();
      } else {
        final snackBar = SnackBar(
          content: Text(context.l10n.unknownAPIError),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }
}
