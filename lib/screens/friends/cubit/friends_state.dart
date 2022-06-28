part of 'friends_cubit.dart';

class FriendsState extends Equatable {
  const FriendsState();

  List<Friend> get friendList => [
        const Friend(
          name: 'Benni R',
          isBestFriend: true,
        ),
        const Friend(
          name: 'Hannah W',
          isBestFriend: true,
        ),
        const Friend(
          name: 'Florian G',
          isBestFriend: true,
        ),
        const Friend(
          name: 'Mia M',
          isBestFriend: true,
        ),
        const Friend(
          name: 'Joel R',
          isBestFriend: true,
        ),
        const Friend(
          name: 'Emily F',
        ),
        const Friend(
          name: 'Filip T',
        ),
        const Friend(
          name: 'Marie S',
        ),
        const Friend(
          name: 'Olivia X',
        ),
        const Friend(
          name: 'Sophia U',
        ),
        const Friend(
          name: 'Emma P',
        ),
        for (int i = 0; i < 20; i++)
          const Friend(
            name: 'John D',
          ),
      ];

  @override
  List<Object> get props => [friendList];
}
