import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:onesignal_repository/onesignal_repository.dart';
import 'package:pickup/screens/home/cubit/home_cubit.dart';
import 'package:pickup/screens/home/view/home_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const route = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final oneSignalRepository = context.read<OneSignalRepository>();
    Future.delayed(
      const Duration(seconds: 2),
      () => oneSignalRepository.initOneSignal(
        dotenv.get('ONESIGNAL_APPID'),
      ),
    );

    return BlocProvider(
      create: (_) => HomeCubit(),
      child: HomeView(),
    );
  }
}
