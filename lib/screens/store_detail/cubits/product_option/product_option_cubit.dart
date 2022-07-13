import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'product_option_state.dart';

class ProductOptionCubit extends Cubit<ProductOptionState> {
  ProductOptionCubit() : super(ProductOptionInitial());
}
