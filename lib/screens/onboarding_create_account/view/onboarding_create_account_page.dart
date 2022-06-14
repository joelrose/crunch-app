import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickup/l10n/l10n.dart';
import 'package:pickup/screens/onboarding_create_account/cubit/onboarding_create_account_cubit.dart';
import 'package:pickup/screens/onboarding_create_account/models/models.dart';
import 'package:pickup/screens/onboarding_create_account/widgets.dart/widgets.dart';

class OnboardingCreateAccountPage extends StatelessWidget {
  const OnboardingCreateAccountPage({Key? key}) : super(key: key);

  static Route<void> route({
    required CreateAccountData data,
  }) {
    return MaterialPageRoute(
      builder: (_) => BlocProvider(
        create: (_) => OnboardingCreateAccountCubit(data: data),
        child: const OnboardingCreateAccountPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const OnboardingCreateAccountView();
  }
}

class OnboardingCreateAccountView extends StatelessWidget {
  const OnboardingCreateAccountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final step = context
        .select((OnboardingCreateAccountCubit cubit) => cubit.state.step);

    return PageWrapper(
      backgroundColor: AlpacaColor.white100Color,
      statusBarStyle: SystemUiOverlayStyle.dark,
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Column(
          children: [
            if (step != OnboardingStep.phoneVerification) ...[
              const _CreateAccountStatusBar(),
            ],
            const _Stack(),
          ],
        ),
      ),
    );
  }
}

class _CreateAccountStatusBar extends StatelessWidget {
  const _CreateAccountStatusBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state =
        context.select((OnboardingCreateAccountCubit cubit) => cubit.state);

    final step = state.step;

    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                '${context.l10n.step} ${step.index}/${state.maxSteps}',
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      color: AlpacaColor.darkNavyColor,
                    ),
              ),
            ),
            if (step == OnboardingStep.phoneVerification)
              Positioned(
                left: 0,
                child: GestureDetector(
                  onTap: () => step == OnboardingStep.phoneVerification
                      ? Navigator.of(context).pop()
                      : context
                          .read<OnboardingCreateAccountCubit>()
                          .previousStep(),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                    color: AlpacaColor.blackColor,
                  ),
                ),
              )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 25.0, bottom: 25),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 5,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: state.maxSteps,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: _getBorderRadius(index, state.maxSteps),
                        color: (step.index - (index + 1)) >= 0
                            ? AlpacaColor.primary100
                            : AlpacaColor.lightGreyColor90,
                      ),
                      margin: EdgeInsets.zero,
                      width: MediaQuery.of(context).size.width *
                          (state.data.isSocialLogin ? 0.445 : 0.21),
                      height: 8,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  BorderRadius _getBorderRadius(int index, int maxSteps) {
    if (index == 0) {
      return const BorderRadius.horizontal(
        left: Radius.circular(20),
      );
    } else if ((index + 1) == maxSteps) {
      return const BorderRadius.horizontal(
        right: Radius.circular(20),
      );
    }

    return BorderRadius.zero;
  }
}

class _Stack extends StatelessWidget {
  const _Stack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);

    final state =
        context.select((OnboardingCreateAccountCubit cubit) => cubit.state);

    return Flexible(
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(
          parent: NeverScrollableScrollPhysics(),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: media.size.width,
            minHeight: media.size.height -
                140 -
                media.viewPadding.bottom -
                media.viewPadding.top,
          ),
          child: IntrinsicHeight(
            child: IndexedStack(
              index: state.data.isSocialLogin
                  ? state.step.index - 1
                  : state.step.index,
              children: [
                if (!state.data.isSocialLogin) ...[
                  StepPhoneVerification(
                    phoneNumber: state.data.phoneNumber!,
                  ),
                ],
                const StepInsertName(),
                const StepPlaceholder(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
