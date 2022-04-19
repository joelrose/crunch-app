import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:pickup/screens/discover/cubit/discover_cubit.dart';
import 'package:pickup/screens/discover/discover.dart';
import 'package:pickup/screens/home/home.dart';
import 'package:pickup/screens/home/view/home_view.dart';
import 'package:pickup/screens/orders/orders.dart';

import '../../helpers/pump_app.dart';
import '../../mock/mock_hermes_service.dart';

void main() {
  group('App Bottom Nav WidgetTest', () {
    testWidgets('Testing Bottom Navigation Bar loaded', (tester) async {
      await mockNetworkImages(() async {
        await tester.pumpApp(
          BlocProvider(
            create: (_) => DiscoverCubit(
              MockHermesService('[]', 200),
            ),
            child: BlocProvider(
              create: (_) => HomeCubit(),
              child: HomeView(),
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.byType(BottomNavigationBar), findsOneWidget);

        expect(find.byType(DiscoverPage), findsOneWidget);
        expect(find.byType(OrdersPage), findsOneWidget);
      });
    });
  });
}
