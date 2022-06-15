import 'package:authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesignal_repository/onesignal_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({
    required AuthenticationRepository authenticationRepository,
    required OneSignalRepository oneSignalRepository,
  })  : _authenticationRepository = authenticationRepository,
        _oneSignalRepository = oneSignalRepository,
        super(const ProfileState(status: ProfileStatus.initial));

  final AuthenticationRepository _authenticationRepository;
  final OneSignalRepository _oneSignalRepository;

  Future<void> logoutUser() async {
    emit(const ProfileState(status: ProfileStatus.loading));

    await _authenticationRepository.signOut();

    await _oneSignalRepository.logout();

    emit(const ProfileState(status: ProfileStatus.loggedOut));
  }
}
