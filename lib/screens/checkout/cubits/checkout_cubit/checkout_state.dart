import 'package:equatable/equatable.dart';
import 'package:hermes_repository/hermes_repository.dart';





class CheckoutState extends Equatable {
  const CheckoutState({required this.menu});

  final GetMenuResponseDto menu;

  @override
  List<Object> get props => [menu];
}
