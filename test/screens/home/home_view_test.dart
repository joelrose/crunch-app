import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hermes_repository/hermes_repository.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:pickup/screens/discover/cubit/discover_cubit.dart';
import 'package:pickup/screens/discover/discover.dart';
import 'package:pickup/screens/home/home.dart';
import 'package:pickup/screens/home/view/home_view.dart';
import 'package:pickup/screens/orders/orders.dart';

import '../../helpers/pump_app.dart';

class MockDiscoverCubit extends MockCubit<DiscoverState>
    implements DiscoverCubit {}

void main() {
  late DiscoverCubit discoverCubit;

  group('App Bottom Nav WidgetTest', () {
    setUp(() {
      discoverCubit = MockDiscoverCubit();
      when(() => discoverCubit.state).thenReturn(
        DiscoverState(
          status: DiscoverStatus.success,
          stores: const [],
        ),
      );
    });

    testWidgets('Testing Bottom Navigation Bar loaded', (tester) async {
      await mockNetworkImages(() async {
        await tester.pumpApp(
          BlocProvider.value(
            value: discoverCubit,
            child: BlocProvider(
              create: (_) => HomeCubit(),
              child: HomeView(),
            ),
          ),
          hermesRepository: MockHermesService('[]', 200),
        );

        await tester.pumpAndSettle();

        expect(find.byType(BottomNavigationBar), findsOneWidget);

        expect(find.byType(DiscoverPage), findsOneWidget);
        expect(find.byType(OrdersPage), findsOneWidget);
      });
    });
  });
}
