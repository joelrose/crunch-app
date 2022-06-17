import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_repository/hermes_repository.dart';
import 'package:pickup/screens/store_information/cubit/cubit.dart';
import 'package:pickup/screens/store_information/view/view.dart';

class StoreInformationPage extends StatelessWidget {
  const StoreInformationPage({Key? key}) : super(key: key);

  static Route<void> route({
    required GetMenuResponseDto menu,
  }) {
    return MaterialPageRoute(
      builder: (_) => BlocProvider(
        create: (_) => StoreInformationCubit(menu),
        child: const StoreInformationPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const PageWrapper(
      backgroundColor: Colors.white,
      statusBarStyle: SystemUiOverlayStyle.dark,
      padding: EdgeInsets.zero,
      child: StoreInformationView(),
    );
  }
}
