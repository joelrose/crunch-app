import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pickup/screens/friends/cubit/cubit.dart';
import 'package:pickup/screens/friends/models/models.dart';

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
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Friends',
                  style: Theme.of(context).textTheme.headline1!.merge(
                        const TextStyle(
                          color: AlpacaColor.blackColor,
                        ),
                      ),
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/gift.svg',
                      height: 26,
                    ),
                    Container(
                      width: 15,
                    ),
                    SvgPicture.asset(
                      'assets/icons/user-plus.svg',
                      height: 26,
                    ),
                  ],
                )
              ],
            ),
          ),
          const Divider(height: 0),
          Flexible(
            child: TabBar(
              indicatorColor: AlpacaColor.blackColor,
              tabs: [
                Tab(
                  child: Text(
                    'Friends',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                Tab(
                  child: Text(
                    'Feed',
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
                _FriendsTab(),
                Container(color: Colors.red),
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
              'Best friends (${bestFriends.length})',
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
              'All friends (${friends.length})',
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
          Expanded(child: _FriendsGrid(friendList: friends)),
        ],
      ),
    );
  }
}

class _FriendsGrid extends StatelessWidget {
  const _FriendsGrid({Key? key, required this.friendList}) : super(key: key);

  final List<Friend> friendList;

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
        return _FriendTile(
          friend: friend,
          color: colors[++i % colors.length],
        );
      }).toList(),
    );
  }
}

class _FriendTile extends StatelessWidget {
  const _FriendTile({
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
      child: Container(
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
