import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hermes_api/swagger_generated_code/swagger.swagger.dart';
import 'package:pickup/shared/extensions.dart';
import 'package:pickup/shared/models/product_detail_model.dart';
import 'package:collection/collection.dart';

part 'store_detail_state.dart';

class StoreDetailCubit extends Cubit<StoreDetailState> {
  StoreDetailCubit(this.data) : super(StoreDetailReload(data, 0, 0)) {
    init();
  }

  final ProductDetailsData data;

  int amountOfProductsToAddToBasket = 1;
  int totalPrice = 0;
  int reload = 0;

  late List<CreateOrderItemDto> orderDto = [];

  void init() {
    totalPrice = data.item.price!;

    final product = data.item;
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
    final item = data.item;

    final newItem = CreateOrderItemDto(
      plu: item.plu,
      price: item.price,
      name: item.name,
      quantity: amountOfProductsToAddToBasket,
      items: _convertToOrderDto(),
    );

    try {
      final items =
          data.checkoutItems.firstWhere((listItem) => listItem == newItem);

      items.quantity = items.quantity! + newItem.quantity!;
    } catch (error) {
      data.checkoutItems.add(newItem);
    }

    data.onCheckoutChange(data.checkoutItems);
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
      StoreDetailReload(
        data,
        _getTotalPrice(),
        reload++,
      ),
    );
  }

  int _getTotalPrice() {
    return totalPrice = amountOfProductsToAddToBasket *
        (PriceCalulcation.getPriceOfItems(orderDto) + data.item.price!);
  }
}
