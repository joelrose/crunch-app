import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pickup/screens/checkout/cubits/checkout_payment_cubit/checkout_payment_cubit.dart';
import 'package:stripe_repository/stripe_repository.dart';

class MockStripeRepository extends Mock implements StripeRepository {}

void main() {
  final StripeRepository stripeRepository = MockStripeRepository();

  group('CheckoutPaymentCubit', () {
    test('initialState', () {
      expect(
        CheckoutPaymentCubit(
          stripeRepository: stripeRepository,
          merchantId: 'merchantId',
        ).state,
        const CheckoutPaymentState(PaymentStatus.initial),
      );
    });

    blocTest<CheckoutPaymentCubit, CheckoutPaymentState>(
      'emits success when checkout succeeds',
      setUp: () {
        when(
          () => stripeRepository
              .presentPaymentSheet(merchantId: 'merchantId', checkoutItems: []),
        ).thenAnswer((_) async {});
      },
      build: () => CheckoutPaymentCubit(
        stripeRepository: stripeRepository,
        merchantId: 'merchantId',
      ),
      act: (cubit) => cubit.checkout([]),
      expect: () => [
        const CheckoutPaymentState(PaymentStatus.loading),
        const CheckoutPaymentState(PaymentStatus.paid),
      ],
    );

    blocTest<CheckoutPaymentCubit, CheckoutPaymentState>(
      'emits failed when exception is thrown',
      setUp: () {
        when(
          () => stripeRepository
              .presentPaymentSheet(merchantId: 'merchantId', checkoutItems: []),
        ).thenAnswer((_) async {
          throw Exception();
        });
      },
      build: () => CheckoutPaymentCubit(
        stripeRepository: stripeRepository,
        merchantId: 'merchantId',
      ),
      act: (cubit) => cubit.checkout([]),
      expect: () => [
        const CheckoutPaymentState(PaymentStatus.loading),
        const CheckoutPaymentState(PaymentStatus.failed),
      ],
    );
  });
}
