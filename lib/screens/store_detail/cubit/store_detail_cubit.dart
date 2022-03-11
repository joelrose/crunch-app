import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pickup/shared/models/product_detail_model.dart';
import 'package:sanity/sanity.dart';

part 'store_detail_state.dart';

class StoreDetailCubit extends Cubit<StoreDetailState> {
  StoreDetailCubit(this.data) : super(StoreDetailReload(data, 0)) {
    init();
  }

  final ProductDetailsData data;

  int amountOfProductsToAddToBasket = 1;
  int productAmountInBasket = 0;
  double newTotalPrice = 0;
  double defaultItemPrice = 0;
  double totalItemPrice = 0;
  late String priceAsString;
  late List<CheckoutItemOptionsModel> itemTitleAndOptionsList;
  late CheckoutItemOptionsModel itemTitleAndOptions;
  late CheckoutOptionForItemOptionsModel itemOption;

  void init() {
    productAmountInBasket = data.checkoutItems
        .where(
          (listItem) => data.item.plu == listItem.plu,
        )
        .length;

    if (_isItemInBasket()) {
      amountOfProductsToAddToBasket = productAmountInBasket;
    } else {
      amountOfProductsToAddToBasket = 1;
      productAmountInBasket = 0;
    }

    defaultItemPrice = data.item.price!.toDouble();
    totalItemPrice = defaultItemPrice;

    final item = data.item;

    itemTitleAndOptionsList = [];
    if (data.item.childProducts != null) {
      if (!_isItemInBasket()) {
        for (final child in item.childProducts!) {
          itemOption = CheckoutOptionForItemOptionsModel(
            plu: child.childProduct!.plu!,
            price: child.childProduct!.price!,
            title: child.childProduct!.name!,
          );
          itemTitleAndOptions = CheckoutItemOptionsModel(
            option: itemOption,
            plu: child.childProduct!.plu!,
          );
          itemTitleAndOptionsList.add(itemTitleAndOptions);
        }
      } else {
        final int itemIndexInBasket = data.checkoutItems.indexWhere(
          (checkoutItem) => checkoutItem.plu == data.item.plu,
        );
        itemTitleAndOptionsList =
            data.checkoutItems[itemIndexInBasket].itemOptionPlus;

        double addOnPrice = 0;
        for (final item in itemTitleAndOptionsList) {
          final itemOptionPrice = item.option.price.toDouble();
          addOnPrice += itemOptionPrice;
        }
        totalItemPrice = defaultItemPrice + addOnPrice;
      }
    }

    newTotalPrice = totalItemPrice * amountOfProductsToAddToBasket;
  }

  void changeItemPrice(
    double singleProductPrice,
    double addOnPrice,
  ) {
    final double newItemPrice = singleProductPrice + addOnPrice;
    totalItemPrice = newItemPrice;
    _calculateNewPrice(
      amountOfProductsToAddToBasket,
      newTotalPrice,
    );
  }

  void increaseItemAmount() {
    amountOfProductsToAddToBasket += 1;
    _calculateNewPrice(
      amountOfProductsToAddToBasket,
      newTotalPrice,
    );
  }

  void decreaseItemAmount() {
    if (amountOfProductsToAddToBasket != 0) {
      amountOfProductsToAddToBasket -= 1;
      _calculateNewPrice(
        amountOfProductsToAddToBasket,
        newTotalPrice,
      );
    }
  }

  void _calculateNewPrice(int amount, double price) {
    newTotalPrice = totalItemPrice * amount;

    emit(StoreDetailReload(data, newTotalPrice));
  }

  void addToOrderOnClick() {
    final item = data.item;
    if (amountOfProductsToAddToBasket < productAmountInBasket) {
      for (var i = productAmountInBasket;
          i > amountOfProductsToAddToBasket;
          i--) {
        data.checkoutItems.removeWhere(
          (checkoutItem) => checkoutItem.plu == data.item.plu,
        );
        productAmountInBasket = 0;
      }
    }
    if (amountOfProductsToAddToBasket > productAmountInBasket) {
      for (var i = productAmountInBasket;
          i < amountOfProductsToAddToBasket;
          i++) {
        data.checkoutItems.add(
          CheckoutItemModel(
            plu: item.plu!,
            itemOptionPlus: itemTitleAndOptionsList,
            price: item.price!,
          ),
        );
      }
    }

    data.onCheckoutChange(data.checkoutItems);
  }

  bool _isItemInBasket() {
    if (data.checkoutItems.indexWhere(
          (checkoutItem) => checkoutItem.plu == data.item.plu,
        ) !=
        -1) {
      return true;
    } else {
      return false;
    }
  }
}
