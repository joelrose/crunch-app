import 'package:equatable/equatable.dart';
import 'package:hermes_repository/hermes_repository.dart';

class CheckoutState extends Equatable {
  const CheckoutState({required this.store});

  final GetStoreResponse store;

  @override
  List<Object> get props => [store];
}
