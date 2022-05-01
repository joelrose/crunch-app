import 'package:flutter_test/flutter_test.dart';
import 'package:hermes_repository/hermes_repository.dart';
import 'package:pickup/shared/price_calculation.dart';

void main() {
  final singleItem1 = CreateOrderItemDto(price: 10, quantity: 1);
  final singleItem2 = CreateOrderItemDto(price: 0, quantity: 10);
  final singleItem3 = CreateOrderItemDto(price: 10, quantity: 10);

  final itemList1 = [singleItem1];
  final itemList2 = [singleItem1, singleItem2, singleItem3];

  group('Price Calculation: getPriceOfItems', () {
    test('list without properties', () {
      expect(PriceCalulcation.getPriceOfItems(itemList1), 10);
      expect(PriceCalulcation.getPriceOfItems(itemList2), 110);
    });
    test('empty list', () {
      expect(PriceCalulcation.getPriceOfItems([]), 0);
    });

    test('empty list', () {
      expect(PriceCalulcation.getPriceOfItems([]), 0);
    });
  });

  group('Price Calculation: getPriceOfItem', () {
    test('single item', () {
      expect(PriceCalulcation.getPriceOfItem(singleItem1), 10);
      expect(PriceCalulcation.getPriceOfItem(singleItem2), 0);
      expect(PriceCalulcation.getPriceOfItem(singleItem3), 100);
    });
  });

  test('Price Calculation: assertItem', () {
    expect(
      () => PriceCalulcation.assertItem(CreateOrderItemDto()),
      throwsAssertionError,
    );

    expect(
      () => PriceCalulcation.assertItem(CreateOrderItemDto(quantity: 1)),
      throwsAssertionError,
    );

    expect(
      () => PriceCalulcation.assertItem(CreateOrderItemDto(quantity: 0)),
      throwsAssertionError,
    );

    expect(
      () => PriceCalulcation.assertItem(CreateOrderItemDto(price: 0)),
      throwsAssertionError,
    );
  });
}
