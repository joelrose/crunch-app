import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:pickup/screens/discover/cubit/discover_cubit.dart';
import 'package:pickup/screens/discover/discover.dart';
import 'package:pickup/screens/home/home.dart';
import 'package:pickup/screens/home/view/home_view.dart';
import 'package:pickup/screens/orders/orders.dart';
import 'package:pickup/services/hermes_service.dart';
import 'package:pickup/services/service_locator.dart';
import 'package:sanity/sanity.dart';

import '../../mock/mock_hermes_service.dart';
import '../../mock/mock_sanity_cms.dart';

Widget createHomeScreen() => MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => DiscoverCubit(
            locator<SanityService>(),
          ),
        ),
      ],
      child: MaterialApp(
        home: BlocProvider(
          create: (_) => HomeCubit(),
          child: HomeView(),
        ),
      ),
    );

void main() {
  setUpAll(() {
    final GetIt locator = GetIt.instance;
    locator.allowReassignment = true;
    locator.registerLazySingleton<HermesService>(
      () => MockHermesService('[]', 200),
    );
    locator.registerLazySingleton<SanityService>(
      () => MockSanityCms(),
    );
  });
  
  group('App Bottom Nav WidgetTest', () {
    testWidgets('Testing Bottom Navigation Bar loaded', (tester) async {
      await mockNetworkImages(() async {
        await tester.pumpWidget(createHomeScreen());
        await tester.pumpAndSettle();

        expect(find.byType(BottomNavigationBar), findsOneWidget);

        expect(find.byType(DiscoverPage), findsOneWidget);
        expect(find.byType(OrdersPage), findsOneWidget);
      });
    });
  });
}