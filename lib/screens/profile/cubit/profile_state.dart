part of 'profile_cubit.dart';

enum ProfileStatus { initial, loading, loggedOut, failed }

class ProfileState extends Equatable {
  const ProfileState({required this.status});

  final ProfileStatus status;

  @override
  List<Object> get props => [status];
}
