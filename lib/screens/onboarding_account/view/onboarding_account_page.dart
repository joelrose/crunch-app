import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickup/screens/onboarding_account/cubit/onboarding_account_cubit.dart';
import 'package:pickup/screens/onboarding_account/widgets/widgets.dart';

class OnboardingAccountPage extends StatelessWidget {
  const OnboardingAccountPage({Key? key}) : super(key: key);

  static Route<void> route({required bool isSignUp}) {
    return MaterialPageRoute(
      builder: (_) => BlocProvider(
        create: (_) => OnboardingAccountCubit(isSignUp: isSignUp),
        child: const OnboardingAccountPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const OnboardingAccountView();
  }
}

class OnboardingAccountView extends StatefulWidget {
  const OnboardingAccountView({Key? key}) : super(key: key);

  @override
  State<OnboardingAccountView> createState() => _OnboardingAccountViewState();
}

class _OnboardingAccountViewState extends State<OnboardingAccountView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      padding: EdgeInsets.zero,
      backgroundColor: AlpacaColor.primary100,
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          _scrollController.jumpTo(0);
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const ClampingScrollPhysics(
            parent: NeverScrollableScrollPhysics(),
          ),
          child: SizedBox(
            height: (MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top) *
                0.98,
            child: _buildStack(context),
          ),
        ),
      ),
    );
  }

  Widget _buildStack(BuildContext context) {
    return Stack(
      children: [
        const _Image(),
        Column(
          children: const [
            _Header(),
            Spacer(),
            OnboardingLoginFields(),
          ],
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 30,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: AlpacaColor.white100Color,
            ),
          ),
        ],
      ),
    );
  }
}

class _Image extends StatelessWidget {
  const _Image({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: -70,
      top: -15,
      height: MediaQuery.of(context).size.height * 0.55,
      child: Transform.rotate(
        angle: -45,
        child: Image.asset(
          'assets/onboarding/create-account-3D.png',
        ),
      ),
    );
  }
}
