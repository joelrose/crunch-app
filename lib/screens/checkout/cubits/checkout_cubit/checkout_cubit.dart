import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_repository/hermes_repository.dart';

import 'package:pickup/screens/checkout/cubits/checkout_cubit/checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit({required GetMenuResponseDto menu})
      : super(CheckoutState(menu: menu));
}
