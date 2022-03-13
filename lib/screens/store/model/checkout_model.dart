import 'package:hermes_api/hermes_api.dart';

class CheckoutItemModel {
  CheckoutItemModel({
    required this.plu,
    required this.itemOptions,
    required this.price,
  });
  
  String plu;
  List<CheckoutItemOptionsModel> itemOptions;
  int price;
}

class CheckoutItemOptionsModel {
  CheckoutItemOptionsModel({
    required this.option,
    required this.categoryPlu,
  });

  CreateOrderItemDto option;
  String categoryPlu;
}
