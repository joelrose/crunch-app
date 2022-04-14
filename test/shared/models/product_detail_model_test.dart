import 'package:flutter_test/flutter_test.dart';
import 'package:hermes_api/hermes_api.dart';
import 'package:mockito/mockito.dart';
import 'package:pickup/shared/models/product_detail_model.dart';

abstract class MyFunction {
  void call(List<CreateOrderItemDto> value);
}

class MyFunctionMock extends Mock implements MyFunction {}

void main() {
  final checkoutItems = [CreateOrderItemDto()];
  final item = DeliverectProductModelDto();

  group('ProductDetailsData Model', () {
    test('onCheckoutChange', () {
      final mock = MyFunctionMock();

      final data = ProductDetailsData(
        checkoutItems: checkoutItems,
        item: item,
        onCheckoutChange: mock,
        restaurantImage: '',
      );

      data.onCheckoutChange(checkoutItems);

      verify(mock(checkoutItems)).called(1);
    });
    test('fields', () {
      final mock = MyFunctionMock();

      final data = ProductDetailsData(
        checkoutItems: checkoutItems,
        item: item,
        onCheckoutChange: mock,
        restaurantImage: 'image',
      );

      expect(data.checkoutItems, checkoutItems);
      expect(data.item, item);
      expect(data.restaurantImage, 'image');
    });
  });
}
