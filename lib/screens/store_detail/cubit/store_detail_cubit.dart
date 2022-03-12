import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pickup/shared/models/product_detail_model.dart';
import 'package:sanity/sanity.dart';

part 'store_detail_state.dart';

class StoreDetailCubit extends Cubit<StoreDetailState> {
  StoreDetailCubit(this.data) : super(StoreDetailReload(data, 0, 0)) {
    init();
  }

  final ProductDetailsData data;

  // how many product should be added to the basket
  int amountOfProductsToAddToBasket = 1;

  // how many product of this item are already in the basket
  int productAmountInBasket = 0;

  int newTotalPrice = 0;
  int totalItemPrice = 0;

  late List<CheckoutItemOptionsModel> categoryList;
  int reload = 0;
  //late CheckoutOptionForItemOptionsModel itemOption;

  void init() {
    final isAlreadyInBasket = _isItemInBasket();

    // check wether there are items of this type already in the basket
    if (isAlreadyInBasket) {
      amountOfProductsToAddToBasket = data.checkoutItems
          .where(
            (listItem) => data.item.plu == listItem.plu,
          )
          .length;
    } else {
      amountOfProductsToAddToBasket = 1;
      productAmountInBasket = 0;
    }

    final itemPrice = totalItemPrice = data.item.price!;

    final item = data.item;

    categoryList = [];

    if (item.childProducts != null) {
      if (!isAlreadyInBasket) {
        for (final child in item.childProducts!) {
          final firstOption =
              child.childProduct!.childProducts![0].childProduct!;

          final itemTitleAndOptions = CheckoutItemOptionsModel(
            option: CheckoutOptionForItemOptionsModel(
              plu: firstOption.plu!,
              price: firstOption.price!,
              name: firstOption.name!,
            ),
            categoryPlu: child.childProduct!.plu!,
          );

          categoryList.add(itemTitleAndOptions);
        }
      } else {
        final int itemIndexInBasket = data.checkoutItems.indexWhere(
          (checkoutItem) => checkoutItem.plu == data.item.plu,
        );

        final test = data.checkoutItems[itemIndexInBasket].itemOptions;

        int addOnPrice = 0;
        for (final item in test) {
          final itemOptionPrice = item.option.price;
          addOnPrice += itemOptionPrice;
        }
        totalItemPrice = itemPrice + addOnPrice;
      }
    }

    newTotalPrice = totalItemPrice * amountOfProductsToAddToBasket;
  }

  void changeItemPrice(
    int singleProductPrice,
    int addOnPrice,
  ) {
    final newItemPrice = singleProductPrice + addOnPrice;
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

  void _calculateNewPrice(int amount, int price) {
    newTotalPrice = totalItemPrice * amount;

    reload++;
    emit(StoreDetailReload(data, newTotalPrice, reload));
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
            itemOptions: categoryList,
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
