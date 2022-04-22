import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_repository/hermes_repository.dart';
import 'package:pickup/screens/store/cubit/store_cubit.dart';
import 'package:pickup/screens/store/view/store_view.dart';

class StorePage extends StatelessWidget {
  const StorePage({Key? key, required this.storeId}) : super(key: key);

  static const route = '/store';

  final String storeId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StoreCubit(
        context.read<HermesRepository>(),
      )..fetchRestaurant(storeId),
      child: const StoreView(),
    );
  }
}
