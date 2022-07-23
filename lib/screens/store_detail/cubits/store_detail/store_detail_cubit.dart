import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_repository/hermes_repository.dart';
import 'package:pickup/shared/price_calculation.dart';

part 'store_detail_state.dart';

class StoreDetailCubit extends Cubit<StoreDetailState> {
  StoreDetailCubit({
    required DeliverectProductModelDto item,
  }) : super(
          StoreDetailState(
            item: item,
            orderItems: const [],
          ),
        ) {
    init();
  }

  void init() {
    final List<CreateOrderItemDto> orderItems = [];

    final product = state.item;

    if (product.childProducts != null) {
      for (final child in product.childProducts!) {
        final firstOption = child.childProduct!.childProducts!.firstWhereOrNull(
          (element) => !element.childProduct!.snoozed!,
        );

        final itemTitleAndOptions = CreateOrderItemDto(
          plu: product.plu,
          price: 0,
          name: product.name,
          quantity: 1,
          items: child.childProduct!.min == 1 && firstOption != null
              ? [
                  CreateOrderItemDto(
                    plu: firstOption.childProduct!.plu,
                    price: firstOption.childProduct!.price,
                    name: firstOption.childProduct!.name,
                    quantity: 1,
                    items: [],
                  )
                ]
              : [],
        );

        orderItems.add(itemTitleAndOptions);
      }
    }

    emit(
      state.copyWith(
        price: _getTotalPrice(),
        orderItems: orderItems,
      ),
    );
  }

  void increaseItemAmount() {
    final basketAmount = state.basketAmount + 1;
    emit(
      state.copyWith(
        price: _getTotalPrice(basketAmount: basketAmount),
        basketAmount: basketAmount,
      ),
    );
  }

  void decreaseItemAmount() {
    if (state.basketAmount != 1) {
      final basketAmount = state.basketAmount - 1;

      emit(
        state.copyWith(
          price: _getTotalPrice(basketAmount: basketAmount),
          basketAmount: basketAmount,
        ),
      );
    }
  }

  void addProductToBasket() {
    emit(
      state.copyWith(
        status: StoreDetailStatus.done,
      ),
    );
  }

  CreateOrderItemDto createOrderItemDto() {
    final item = state.item;

    return CreateOrderItemDto(
      plu: item.plu,
      price: item.price,
      name: item.name,
      quantity: state.basketAmount,
      items: _convertToOrderDto(),
    );
  }

  List<CreateOrderItemDto> _convertToOrderDto() {
    final List<CreateOrderItemDto> returnValue = [];

    for (final optionCategory in state.orderItems) {
      if (optionCategory.items != null) {
        optionCategory.items!.sort((a, b) => a.name!.compareTo(b.name!));
        returnValue.addAll(optionCategory.items!);
      }
    }
    return returnValue;
  }

  int _getTotalPrice({int? basketAmount}) {
    return (basketAmount ?? state.basketAmount) *
        (PriceCalulcation.getPriceOfItems(state.orderItems) +
            state.item.price!);
  }

  void _emitNewState() {
    emit(
      state.copyWith(
        price: _getTotalPrice(),
        magicNumber: state.magicNumber + 1,
      ),
    );
  }

  // ORDERITEM

  void addRadioOrderItem(int categoryIndex, CreateOrderItemDto item) {
    final dto = state.orderItems[categoryIndex].items!;

    dto.clear();

    dto.add(item);

    state.orderItems[categoryIndex].items = dto;

    _emitNewState();
  }

  void addCheckBoxOrderItem(int categoryIndex, CreateOrderItemDto item) {
    final dto = state.orderItems[categoryIndex].items!;

    final index = dto.indexWhere(
      (element) => element.plu == item.plu!,
    );

    if (index != -1) {
      dto.removeAt(index);
    } else {
      dto.add(item);
    }

    state.orderItems[categoryIndex].items = dto;

    _emitNewState();
  }

  void decreaseOrderItem(int categoryIndex, String? plu) {
    final dto = state.orderItems[categoryIndex].items!;

    final index = dto.firstWhereOrNull(
      (element) => element.plu == plu,
    );

    if (index != null && index.quantity != 1) {
      index.quantity = index.quantity! - 1;
    } else {
      dto.remove(index);
    }

    _emitNewState();
  }

  void increaseOrderItem(int categoryIndex, String? plu, int maximalQuantity) {
    final dto = state.orderItems[categoryIndex].items!;

    final index = dto.firstWhereOrNull(
      (element) => element.plu == plu!,
    );

    if (index != null && index.quantity! < maximalQuantity) {
      index.quantity = index.quantity! + 1;
    }

    _emitNewState();
  }
}
