import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hermes_repository/hermes_repository.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:pickup/screens/app/app.dart';
import 'package:pickup/screens/checkout/cubits/checkout_cubit/checkout_cubit.dart';
import 'package:pickup/screens/checkout/cubits/checkout_cubit/checkout_state.dart';
import 'package:pickup/screens/checkout/cubits/checkout_payment_cubit/checkout_payment_cubit.dart';
import 'package:pickup/screens/checkout/cubits/checkout_timer_cubit/checkout_time_cubit.dart';
import 'package:pickup/screens/checkout/domain/entities/opening_hour.dart';
import 'package:pickup/screens/checkout/presentation/screen/checkout_page.dart';

import '../../../helpers/pump_app.dart';

final mockMenuModel = GetMenuResponseDto(
  id: 'id',
  googleMapsLink: 'googleMapsLink',
  menu: DeliverectMenuDto(
    menu: 'asdfa',
    availabilities: [
      DeliverectAvailabilityModel(
        dayOfWeek: DeliverectDay.friday,
        startTime: '01:00',
        endTime: '20:00',
      ),
      DeliverectAvailabilityModel(
        dayOfWeek: DeliverectDay.thursday,
        startTime: '09:00',
        endTime: '12:00',
      ),
      DeliverectAvailabilityModel(
        dayOfWeek: DeliverectDay.thursday,
        startTime: '13:00',
        endTime: '14:00',
      ),
    ],
  ),
);

final mockOpeningHours = [
  DeliverectAvailabilityModel(
    dayOfWeek: DeliverectDay.thursday,
    startTime: '09:00',
    endTime: '12:00',
  ),
];

final mockAvailableOpeningHours = [
  OpeningHour(10, List.generate(45, (index) => index + 15)),
  OpeningHour(11, List.generate(60, (index) => index)),
  //OpeningHour(13, List.generate(60, (index) => index))
];

final mockOpeningHour =
    OpeningHour(10, List.generate(45, (index) => index + 15));

final mockCurrentTime = DateTime(2022, 5, 12, 9, 55);

final mockCurrentPickUpTime = DateTime(2022, 5, 12, 10, 15);

class MockCheckoutCubit extends Mock implements CheckoutCubit {}

class MockCheckoutTimeCubit extends Mock implements CheckoutTimeCubit {}

class MockCheckoutPaymentCubit extends Mock implements CheckoutPaymentCubit {}

class MockCheckoutBloc extends Mock implements CheckoutBasketBloc {}

final CheckoutTimeCubit checkoutTimeCubit = MockCheckoutTimeCubit();
final CheckoutPaymentCubit checkoutPaymentCubit = MockCheckoutPaymentCubit();
final CheckoutCubit checkoutCubit = MockCheckoutCubit();
final CheckoutBasketBloc checkoutBasketBloc = MockCheckoutBloc();

CheckoutTimeState getCheckoutTimeState() => CheckoutTimeState(
      mockCurrentPickUpTime,
      mockOpeningHour,
      0,
      mockAvailableOpeningHours,
    );

void main() {
  group(
    'Checkout Page',
    () {
      when(() => checkoutPaymentCubit.state)
          .thenReturn(const CheckoutPaymentState(PaymentStatus.loading));

      when(() => checkoutCubit.state)
          .thenReturn(CheckoutState(menu: mockMenuModel));

      when(() => checkoutTimeCubit.state).thenReturn(getCheckoutTimeState());

      when(() => checkoutCubit.close()).thenAnswer((_) async {});
      when(() => checkoutTimeCubit.close()).thenAnswer((_) async {});
      when(() => checkoutPaymentCubit.close()).thenAnswer((_) async {});
      when(() => checkoutBasketBloc.close()).thenAnswer((_) async {});

      whenListen(
        checkoutPaymentCubit,
        Stream.fromIterable([
          const CheckoutPaymentState(PaymentStatus.initial),
        ]),
      );

      whenListen(
        checkoutBasketBloc,
        Stream.fromIterable([const CheckoutBasketState()]),
      );

      whenListen(
        checkoutTimeCubit,
        Stream.fromIterable([getCheckoutTimeState()]),
      );

      whenListen(checkoutCubit,
          Stream.fromIterable([CheckoutState(menu: mockMenuModel)]));

      testWidgets('renders CheckoutPage', (tester) async {
        await tester.pumpApp(MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => checkoutTimeCubit),
            BlocProvider(create: (_) => checkoutPaymentCubit),
            BlocProvider(create: (_) => checkoutCubit),
          ],
          child: const CheckoutPage(),
        ));

        expect(find.byType(CheckoutPage), findsOneWidget);
      });

      testWidgets('renders time pick bottom sheet', (tester) async {
        await tester.pumpApp(MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => checkoutTimeCubit),
            BlocProvider(create: (_) => checkoutPaymentCubit),
            BlocProvider(create: (_) => checkoutCubit),
          ],
          child: const CheckoutPage(),
        ));
        final pickTimeButton = find.byKey(const Key('PickTimeButton'));

        await tester.tap(pickTimeButton);
        await tester.pump();

        expect(find.byType(ListWheelScrollView), findsNWidgets(2));
      });
    },
  );
}
