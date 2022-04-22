import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickup/l10n/l10n.dart';
import 'package:pickup/screens/onboarding_create_account/cubit/onboarding_create_account_cubit.dart';

class StepSetPassword extends StatefulWidget {
  const StepSetPassword({Key? key}) : super(key: key);

  @override
  _StepSetPasswordState createState() => _StepSetPasswordState();
}

class _StepSetPasswordState extends State<StepSetPassword> {
  final _passwordController = TextEditingController();
  final _passwordRepeatController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _passwordController.dispose();
    _passwordRepeatController.dispose();

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
            context.l10n.onboardingPasswordTitle,
            style: theme.headline1!.copyWith(
              color: AlpacaColor.blackColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 10),
            child: Text(
              context.l10n.onboardingPasswordDescription,
              style: theme.headline5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: AlpacaTextField(
              key: const Key('onboarding_password_textfield'),
              hintText: context.l10n.password,
              textController: _passwordController,
              obscureText: true,
              textInputType: TextInputType.visiblePassword,
              validator: (value) {
                if (value!.isEmpty || value.length < 6) {
                  return context.l10n.onboardingPasswordNotValid;
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: AlpacaTextField(
              key: const Key('onboarding_repeat_password_textfield'),
              hintText: context.l10n.repeatPassword,
              textController: _passwordRepeatController,
              obscureText: true,
              textInputType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              validator: (value) {
                if (value!.isEmpty || _passwordController.text != value) {
                  return context.l10n.onboardingPasswordNotMatching;
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
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                context.read<OnboardingCreateAccountCubit>().nextStep();
              }
            },
          ),
        ],
      ),
    );
  }
}
