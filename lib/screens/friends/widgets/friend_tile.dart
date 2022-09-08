import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:pickup/screens/friends/models/models.dart';

class FriendTile extends StatelessWidget {
  const FriendTile({
    Key? key,
    required this.friend,
    required this.color,
  }) : super(key: key);

  final Friend friend;
  final FriendColor color;

  @override
  Widget build(BuildContext context) {
    final splitName = friend.name.split(' ');

    final initials = splitName.map((name) => name.substring(0, 1)).join();

    final lastName = splitName.last
        .split(' ')
        .map((name) => '${name.substring(0, 1)}.')
        .join();
    final name = '${splitName.first} $lastName';

    return Material(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color.secondaryColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: AlpacaColor.white100Color,
              child: Text(
                initials,
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      color: color.primaryColor,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                name,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: color.primaryColor,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
