part of 'checkout_basket_bloc.dart';

abstract class CheckoutBasketEvent extends Equatable {
  const CheckoutBasketEvent();

  @override
  List<Object> get props => [];
}

class CheckoutBasketSubscriptionRequested extends CheckoutBasketEvent {
  const CheckoutBasketSubscriptionRequested();
}

abstract class CheckoutBasketItemEvent extends CheckoutBasketEvent {
  const CheckoutBasketItemEvent({required this.itemIndex});

  final int itemIndex;

  @override
  List<Object> get props => [itemIndex];
}

class CheckoutBasketItemUpdated extends CheckoutBasketEvent {
  const CheckoutBasketItemUpdated({required this.checkoutItems});

  final List<CreateOrderItemDto> checkoutItems;

  @override
  List<Object> get props => [checkoutItems];
}

class CheckoutBasketItemDeleted extends CheckoutBasketItemEvent {
  const CheckoutBasketItemDeleted({required int itemIndex})
      : super(itemIndex: itemIndex);
}

class CheckoutBasketItemQuantityIncremented extends CheckoutBasketItemEvent {
  const CheckoutBasketItemQuantityIncremented({required int itemIndex})
      : super(itemIndex: itemIndex);
}

class CheckoutBasketItemQuantityDecremented extends CheckoutBasketItemEvent {
  const CheckoutBasketItemQuantityDecremented({required int itemIndex})
      : super(itemIndex: itemIndex);
}
