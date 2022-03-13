import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hermes_api/swagger_generated_code/swagger.swagger.dart';
import 'package:pickup/shared/extensions.dart';
import 'package:pickup/shared/models/product_detail_model.dart';

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
        final firstOption = child.childProduct!.childProducts![0].childProduct!;

        final itemTitleAndOptions = CreateOrderItemDto(
          plu: product.plu,
          price: 0,
          name: product.name,
          items: [
            CreateOrderItemDto(
              plu: firstOption.plu,
              price: firstOption.price,
              name: firstOption.name,
            )
          ],
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

    data.checkoutItems.add(
      CreateOrderItemDto(
        plu: item.plu,
        price: item.price,
        name: item.name,
        quantity: amountOfProductsToAddToBasket,
        items: _convertToOrderList(),
      ),
    );

    data.onCheckoutChange(data.checkoutItems);
  }

  List<CreateOrderItemDto> _convertToOrderList() {
    List<CreateOrderItemDto> returnValue = [];
    for (final optionCategory in orderDto) {
      if(optionCategory.items != null) {
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
