import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickup/screens/friends/cubit/cubit.dart';
import 'package:pickup/screens/friends/view/friends_view.dart';

class FriendsPage extends StatelessWidget {
  const FriendsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FriendsCubit(),
      child: const FriendsView(),
    );
  }
}
