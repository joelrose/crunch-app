import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickup/l10n/l10n.dart';
import 'package:pickup/screens/friends/cubit/cubit.dart';
import 'package:pickup/screens/friends/models/models.dart';
import 'package:pickup/screens/friends/widgets/widgets.dart';

class FriendsView extends StatelessWidget {
  const FriendsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AlpacaHeader(
            title: context.l10n.friends,
            headerItems: [
              HeaderItem(
                onPressed: () {},
                svgPath: 'assets/icons/gift.svg',
              ),
              HeaderItem(
                onPressed: () {},
                svgPath: 'assets/icons/user-plus.svg',
              ),
            ],
          ),
          Flexible(
            child: TabBar(
              indicatorColor: AlpacaColor.blackColor,
              tabs: [
                Tab(
                  child: Text(
                    context.l10n.friends,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                Tab(
                  child: Text(
                    context.l10n.feed,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 10,
            child: TabBarView(
              children: [
                const _FriendsTab(),
                Column(
                  children: List.generate(
                    10,
                    (index) => Column(
                      children: const [
                        Divider(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FriendsTab extends StatelessWidget {
  const _FriendsTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _FriendsList();
  }
}

class _FriendsList extends StatelessWidget {
  const _FriendsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final friendsList =
        context.select((FriendsCubit cubit) => cubit.state.friendList);

    final bestFriends =
        friendsList.where((friend) => friend.isBestFriend).toList();

    final friends =
        friendsList.where((friend) => !friend.isBestFriend).toList();

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              '${context.l10n.bestFriends} (${bestFriends.length})',
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
          Expanded(flex: 0, child: _FriendsGrid(friendList: bestFriends)),
          Container(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              '${context.l10n.allFriends} (${friends.length})',
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
          Expanded(
            child: _FriendsGrid(
              friendList: friends,
              reversedColors: true,
            ),
          ),
        ],
      ),
    );
  }
}

class _FriendsGrid extends StatelessWidget {
  const _FriendsGrid({
    Key? key,
    required this.friendList,
    this.reversedColors = false,
  }) : super(key: key);

  final List<Friend> friendList;
  final bool reversedColors;

  List<FriendColor> get colors => const [
        FriendColor(
          primaryColor: Color(0xFF002B80),
          secondaryColor: Color(0xFFD8E5FF),
        ),
        FriendColor(
          primaryColor: Color(0xFF661A1A),
          secondaryColor: Color(0xFFFEDDDE),
        ),
        FriendColor(
          primaryColor: Color(0xFF7D5F03),
          secondaryColor: Color(0xFFFFEFC7),
        ),
        FriendColor(
          primaryColor: Color(0xFF126E58),
          secondaryColor: Color(0xFFCFEFE7),
        ),
        FriendColor(
          primaryColor: Color(0xFF33047B),
          secondaryColor: Color(0xFFEDE2FE),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    int i = 0;
    return GridView.count(
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 3,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      children: friendList.map((friend) {
        int index = ++i % colors.length;

        if (reversedColors) {
          index = (colors.length - 1) - index;
        }

        return FriendTile(
          friend: friend,
          color: colors[index],
        );
      }).toList(),
    );
  }
}
