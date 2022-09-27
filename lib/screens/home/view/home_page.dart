import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:onesignal_repository/onesignal_repository.dart';
import 'package:pickup/screens/app/bloc/app_outdated/app_outdated_bloc.dart';
import 'package:pickup/screens/app/cubit/user/user_cubit.dart';
import 'package:pickup/screens/discover/cubit/discover_cubit.dart';
import 'package:pickup/screens/home/cubit/home_cubit.dart';
import 'package:pickup/screens/home/view/home_view.dart';
import 'package:pickup/screens/outdated/view/view.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const route = '/home';

  @override
  Widget build(BuildContext context) {
    final oneSignalRepository = context.read<OneSignalRepository>();
    Future.delayed(
      const Duration(seconds: 2),
      () => oneSignalRepository.initOneSignal(
        dotenv.get('ONESIGNAL_APPID'),
      ),
    );

    context.read<UserCubit>().fetchUser();

    context.read<DiscoverCubit>().fetchRestaurants();

    return BlocListener<AppOutdatedBloc, AppOutdatedState>(
      listener: (context, state) {
        if (state.status == AppOutdatedStatus.outdated) {
          Navigator.of(context).pushAndRemoveUntil(
            OutdatedPage.route(),
            (_) => false,
          );
        }
      },
      child: BlocProvider(
        create: (_) => HomeCubit(),
        child: HomeView(),
      ),
    );
  }
}
