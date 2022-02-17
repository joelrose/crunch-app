class PriceData {
  PriceData({
    required this.totalItemPrice,
    required this.amountOfProductsToAddToBasket,
    required this.newTotalPrice,
  });
  double totalItemPrice;
  int amountOfProductsToAddToBasket;
  double newTotalPrice;
}

class ProductAmountAndPricesData {
  ProductAmountAndPricesData({
    required this.amountOfProductsToAddToBasket,
    required this.newTotalPrice,
    required this.increaseItemAmount,
    required this.decreaseItemAmount,
    required this.addToOrderOnClick,
  });
  int amountOfProductsToAddToBasket;
  double newTotalPrice;
  Function increaseItemAmount;
  Function decreaseItemAmount;
  Function addToOrderOnClick;
}
