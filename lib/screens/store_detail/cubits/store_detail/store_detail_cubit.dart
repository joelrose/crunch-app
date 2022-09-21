import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_repository/hermes_repository.dart';
import 'package:pickup/shared/price_calculation.dart';

part 'store_detail_state.dart';

class StoreDetailCubit extends Cubit<StoreDetailState> {
  StoreDetailCubit({
    required GetStoreProduct item,
  }) : super(
          StoreDetailState(
            item: item,
            orderItems: const [],
          ),
        ) {
    init();
  }

  void init() {
    final List<OrderItem> orderItems = [];

    final product = state.item;

    if (product.products != null) {
      for (final child in product.products!) {
        final firstOption = child.products!.firstWhereOrNull(
          (element) => !element.snoozed!,
        );

        final itemTitleAndOptions = OrderItem(
          plu: product.plu,
          price: 0,
          name: product.name,
          quantity: 1,
          subItems: child.min == 1 && firstOption != null
              ? [
                  OrderItem(
                    plu: firstOption.plu,
                    price: firstOption.price,
                    name: firstOption.name,
                    quantity: 1,
                    subItems: [],
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

  OrderItem createOrderItemDto() {
    final item = state.item;

    return OrderItem(
      plu: item.plu,
      price: item.price,
      name: item.name,
      quantity: state.basketAmount,
      subItems: _convertToOrderDto(),
    );
  }

  List<OrderItem> _convertToOrderDto() {
    final List<OrderItem> returnValue = [];

    for (final optionCategory in state.orderItems) {
      if (optionCategory.subItems != null) {
        optionCategory.subItems!.sort((a, b) => a.name!.compareTo(b.name!));
        returnValue.addAll(optionCategory.subItems!);
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

  void addRadioOrderItem(int categoryIndex, OrderItem item) {
    final dto = state.orderItems[categoryIndex].subItems!;

    dto.clear();

    dto.add(item);

    state.orderItems[categoryIndex] = state.orderItems[categoryIndex].copyWith(
      subItems: dto,
    );

    _emitNewState();
  }

  void addCheckBoxOrderItem(int categoryIndex, OrderItem item) {
    final dto = state.orderItems[categoryIndex].subItems!;

    final index = dto.indexWhere(
      (element) => element.plu == item.plu!,
    );

    if (index != -1) {
      dto.removeAt(index);
    } else {
      dto.add(item);
    }

    state.orderItems[categoryIndex] = state.orderItems[categoryIndex].copyWith(
      subItems: dto,
    );

    _emitNewState();
  }

  void decreaseOrderItem(int categoryIndex, String? plu) {
    final dto = state.orderItems[categoryIndex].subItems!;

    final item = dto.firstWhereOrNull(
      (element) => element.plu == plu,
    );

    if (item != null && item.quantity != 1) {
      state.orderItems[categoryIndex].subItems![dto.indexOf(item)] =
          item.copyWith(quantity: item.quantity! - 1);
    } else {
       state.orderItems[categoryIndex].subItems!.remove(item);
    }

    _emitNewState();
  }

  void increaseOrderItem(int categoryIndex, String? plu, int maximalQuantity) {
    final dto = state.orderItems[categoryIndex].subItems!;

    final item = dto.firstWhereOrNull(
      (element) => element.plu == plu!,
    );

    if (item != null && item.quantity! < maximalQuantity) {
      state.orderItems[categoryIndex].subItems![dto.indexOf(item)] =
          item.copyWith(quantity: item.quantity! + 1);
    }

    _emitNewState();
  }
}
