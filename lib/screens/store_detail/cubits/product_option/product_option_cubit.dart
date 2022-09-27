import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_repository/hermes_repository.dart';

part 'product_option_state.dart';

class ProductOptionCubit extends Cubit<ProductOptionState> {
  ProductOptionCubit({
    required int index,
    required GetStoreProduct optionCategory,
  }) : super(
          ProductOptionState(
            index: index,
            optionCategory: optionCategory,
          ),
        );
}
