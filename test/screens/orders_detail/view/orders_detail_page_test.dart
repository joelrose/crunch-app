import 'package:alpaca/alpaca.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hermes_repository/hermes_repository.dart';
import 'package:pickup/screens/orders_detail/view/orders_detail_page.dart';
import 'package:pickup/screens/orders_detail/widgets/widgets.dart';

import '../../../helpers/pump_app.dart';

final mockOrderResponse = GetOrderResponseDto(
  id: '90804119-fbe9-4e3e-a677-1efd689ffbc1',
  merchant: MerchantModelDto(
    name: 'Test Merchant',
    googleMapsLink: 'https://google.com',
  ),
  items: [
    OrderItemModel(
      name: 'Name',
      price: 12,
    ),
  ],
  price: 12,
  estimatedPickUpTime: DateTime(
    2020,
    1,
    1,
    12,
  ),
  status: DeliverectOrderStatus.$new,
);

void main() {
  group(
    'Order detail page',
    () {
      testWidgets('page loads and shows content', (tester) async {
        await tester.pumpApp(OrdersDetailPage(order: mockOrderResponse));

        expect(find.byType(CrunchMap), findsOneWidget);
        expect(find.byType(Detail), findsOneWidget);
        expect(find.byType(ItemList), findsOneWidget);
        expect(find.byType(ActionButton), findsOneWidget);
      });
    },
  );
}
