import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'store_detail_state.dart';

class StoreDetailCubit extends Cubit<StoreDetailState> {
  StoreDetailCubit() : super(StoreDetailInitial());
}
