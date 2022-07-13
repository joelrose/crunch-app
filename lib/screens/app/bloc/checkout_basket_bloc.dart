import 'package:checkout_repository/checkout_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_repository/hermes_repository.dart';

part 'checkout_basket_event.dart';
part 'checkout_basket_state.dart';

class CheckoutBasketBloc
    extends Bloc<CheckoutBasketEvent, CheckoutBasketState> {
  CheckoutBasketBloc({required CheckoutRepository checkoutRepository})
      : _checkoutRepository = checkoutRepository,
        super(const CheckoutBasketState()) {
    on<CheckoutBasketSubscriptionRequested>(_onSubscriptionRequested);
    on<CheckoutBasketItemQuantityDecremented>(_onItemDecremented);
    on<CheckoutBasketItemQuantityIncremented>(_onItemIncremented);
    on<CheckoutBasketItemDeleted>(_onItemDeleted);
    on<CheckoutBasketItemAdded>(_onItemAdded);
  }

  final CheckoutRepository _checkoutRepository;

  Future<void> _onSubscriptionRequested(
    CheckoutBasketSubscriptionRequested event,
    Emitter<CheckoutBasketState> emit,
  ) async {
    emit(state.copyWith(status: () => CheckoutBasketStatus.loading));

    await emit.forEach<List<CreateOrderItemDto>>(
      _checkoutRepository.getCheckoutItems(),
      onData: (checkoutItems) => state.copyWith(
        status: () => CheckoutBasketStatus.success,
        checkoutItems: () => checkoutItems,
      ),
      onError: (_, __) => state.copyWith(
        status: () => CheckoutBasketStatus.failure,
      ),
    );
  }

  Future<void> _onItemDeleted(
    CheckoutBasketItemDeleted event,
    Emitter<CheckoutBasketState> emit,
  ) async {
    await _checkoutRepository.deleteItem(event.itemIndex);
  }

  Future<void> _onItemDecremented(
    CheckoutBasketItemQuantityDecremented event,
    Emitter<CheckoutBasketState> emit,
  ) async {
    await _checkoutRepository.decrementItemQuantity(event.itemIndex);
  }

  Future<void> _onItemIncremented(
    CheckoutBasketItemQuantityIncremented event,
    Emitter<CheckoutBasketState> emit,
  ) async {
    await _checkoutRepository.incrementItemQuantity(event.itemIndex);
  }

  Future<void> _onItemAdded(
    CheckoutBasketItemAdded event,
    Emitter<CheckoutBasketState> emit,
  ) async {
    await _checkoutRepository.addItem(event.item);
  }

  int getAmount(String plu) {
    final items = state.checkoutItems.where(
      (listItem) => plu == listItem.plu,
    );

    return items.fold(
      0,
      (previousValue, element) => previousValue + element.quantity!,
    );
  }
}
