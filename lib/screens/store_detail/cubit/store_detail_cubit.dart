import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_repository/hermes_repository.dart';
import 'package:pickup/shared/price_calculation.dart';

part 'store_detail_state.dart';

class StoreDetailCubit extends Cubit<StoreDetailState> {
  StoreDetailCubit({
    required DeliverectProductModelDto item,
    required List<CreateOrderItemDto> checkoutItems,
  }) : super(
          StoreDetailState(
            checkoutItems: checkoutItems,
            item: item,
          ),
        ) {
    init();
  }

  int amountOfProductsToAddToBasket = 1;
  int totalPrice = 0;
  int reload = 0;

  late List<CreateOrderItemDto> orderDto = [];

  void init() {
    totalPrice = state.item.price!;

    _sortItems(state.item.childProducts);

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
                  )
                ]
              : [],
        );

        orderDto.add(itemTitleAndOptions);
      }
    }

    _calculateNewPrice();
  }

  void _sortItems(List<ProductRelationModelDto>? list) {
    if (list == null) {
      return;
    }

    list.sort(
      (a, b) =>
          a.childProduct!.sortOrder!.compareTo(b.childProduct!.sortOrder!),
    );

    for (final element in list) {
      _sortItems(element.childProduct!.childProducts);
    }
  }

  void changeItemPrice() {
    _calculateNewPrice();
  }

  void increaseItemAmount() {
    amountOfProductsToAddToBasket += 1;
    _calculateNewPrice();
  }

  void decreaseItemAmount() {
    if (amountOfProductsToAddToBasket != 1) {
      amountOfProductsToAddToBasket -= 1;
      _calculateNewPrice();
    }
  }

  void addToOrderOnClick() {
    final item = state.item;
    var checkoutItems = state.checkoutItems.toList();

    final newItem = CreateOrderItemDto(
      plu: item.plu,
      price: item.price,
      name: item.name,
      quantity: amountOfProductsToAddToBasket,
      items: _convertToOrderDto(),
    );

    // We have to remove the quantity here 
    final checkoutItem =
        checkoutItems.firstWhereOrNull((listItem) => listItem == newItem);

    if (checkoutItem == null) {
      checkoutItems.add(newItem);
    } else {
      checkoutItem.quantity = checkoutItem.quantity! + newItem.quantity!;
    }

    emit(
      state.copyWith(
        status: StoreDetailStatus.done,
        checkoutItems: checkoutItems,
      ),
    );
  }

  List<CreateOrderItemDto> _convertToOrderDto() {
    List<CreateOrderItemDto> returnValue = [];

    for (final optionCategory in orderDto) {
      if (optionCategory.items != null) {
        optionCategory.items!.sort((a, b) => a.name!.compareTo(b.name!));
        returnValue.addAll(optionCategory.items!);
      }
    }
    return returnValue;
  }

  void _calculateNewPrice() {
    emit(
      state.copyWith(
        price: _getTotalPrice(),
      ),
    );
  }

  int _getTotalPrice() {
    return totalPrice = amountOfProductsToAddToBasket *
        (PriceCalulcation.getPriceOfItems(orderDto) + state.item.price!);
  }
}
