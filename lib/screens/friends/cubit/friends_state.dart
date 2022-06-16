part of 'friends_cubit.dart';

class FriendsState extends Equatable {
  const FriendsState();

  List<Friend> get friendList => const [
        Friend(
          name: 'Joel Rose',
          isBestFriend: true,
        ),
        Friend(
          name: 'Filip Tsolov',
          isBestFriend: true,
        ),
        Friend(
          name: 'Hauke G',
        ),
        Friend(
          name: 'Lennart S',
        ),
        Friend(
          name: 'Tim C',
        ),
        Friend(
          name: 'Max B',
        ),
        Friend(
          name: 'Luis G',
        ),
        Friend(
          name: 'Florian G',
        ),
        Friend(
          name: 'Matthias F',
        ),
      ];

  @override
  List<Object> get props => [friendList];
}
