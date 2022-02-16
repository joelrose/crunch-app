import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:pickup/screens/home/cubit/home_cubit.dart';
import 'package:pickup/screens/home/view/home_view.dart';
import 'package:pickup/services/auth_service.dart';
import 'package:pickup/services/service_locator.dart';

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

    Future.delayed(const Duration(seconds: 2), () => initOneSignal());
  }

  Future<void> initOneSignal() async {
    OneSignal.shared.setAppId(dotenv.get('ONESIGNAL_APPID'));

    OneSignal.shared
        .promptUserForPushNotificationPermission()
        .then((accepted) async {
      final auth = locator<AuthService>();
      final user = await auth.getUser;
      if (user != null) {
        OneSignal.shared.setExternalUserId(user.uid);

        if (user.email != null) {
          OneSignal.shared.setEmail(email: user.email!);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: HomeView(),
    );
  }
}
