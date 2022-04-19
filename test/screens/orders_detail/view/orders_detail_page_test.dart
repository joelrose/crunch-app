import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hermes_repository/hermes_repository.dart';
import 'package:pickup/screens/orders_detail/view/orders_detail_page.dart';

void main() {
  group(
    'Order detail page',
    () {
      testWidgets('page loads and shows content', (tester) async {
        await tester.pumpWidget(OrdersDetailPage(order: GetOrderResponseDto()));

        expect(find.byType(Container), findsOneWidget);
      });
    },
  );
}
