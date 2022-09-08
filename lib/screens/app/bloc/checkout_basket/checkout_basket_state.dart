part of 'checkout_basket_bloc.dart';

enum CheckoutBasketStatus { initial, loading, success, failure }

class CheckoutBasketState extends Equatable {
  const CheckoutBasketState({
    this.status = CheckoutBasketStatus.initial,
    this.checkoutItems = const [],
  });

  final CheckoutBasketStatus status;
  final List<CreateOrderItemDto> checkoutItems;

  CheckoutBasketState copyWith({
    CheckoutBasketStatus Function()? status,
    List<CreateOrderItemDto> Function()? checkoutItems,
  }) {
    return CheckoutBasketState(
      status: status != null ? status() : this.status,
      checkoutItems:
          checkoutItems != null ? checkoutItems() : this.checkoutItems,
    );
  }

  @override
  List<Object?> get props => [
        status,
        checkoutItems,
      ];
}
