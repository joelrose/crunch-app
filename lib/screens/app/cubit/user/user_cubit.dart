import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_repository/hermes_repository.dart';

part '../../../../shared/base_state.dart';

class UserCubit extends Cubit<BaseState<GetUserResponseDto>> {
  UserCubit({
    required HermesRepository hermesRepository,
  })  : _hermesRepository = hermesRepository,
        super(const BaseState<GetUserResponseDto>());

  final HermesRepository _hermesRepository;

  Future<void> fetchUser() async {
    emit(const BaseState<GetUserResponseDto>(status: BaseStatus.loading));

    try {
      final response = await _hermesRepository.client.apiUsersGet();

      if (response.isSuccessful) {
        emit(
          BaseState<GetUserResponseDto>(
            status: BaseStatus.successful,
            model: response.body,
          ),
        );
      } else {
        emit(const BaseState<GetUserResponseDto>(status: BaseStatus.failed));
      }
    } catch (e) {
      emit(const BaseState<GetUserResponseDto>(status: BaseStatus.failed));
    }
  }
}
