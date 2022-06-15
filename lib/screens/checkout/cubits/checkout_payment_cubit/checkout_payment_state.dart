part of 'checkout_payment_cubit.dart';

enum PaymentStatus { initial, loading, paid, failed }

extension PaymentStatusX on PaymentStatus {
  bool get isInitial => this == PaymentStatus.initial;
  bool get isLoading => this == PaymentStatus.loading;
  bool get isPaid => this == PaymentStatus.paid;
  bool get isFailed => this == PaymentStatus.failed;
}

class CheckoutPaymentState extends Equatable {
  const CheckoutPaymentState(this.status);

  final PaymentStatus status;

  @override
  List<Object> get props => [status];
}
