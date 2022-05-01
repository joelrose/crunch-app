part of 'checkout_cubit.dart';

class CheckoutState extends Equatable {
  const CheckoutState({required this.menu});

  final GetMenuResponseDto menu;

  @override
  List<Object> get props => [menu];
}
