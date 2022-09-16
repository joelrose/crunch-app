import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_repository/hermes_repository.dart';

part 'store_information_state.dart';

class StoreInformationCubit extends Cubit<StoreInformationState> {
  StoreInformationCubit(GetStoreResponse store)
      : super(StoreInformationState(store));
}
