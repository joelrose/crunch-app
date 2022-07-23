part of 'store_detail_cubit.dart';

enum StoreDetailStatus { initial, reloading, done }

class StoreDetailState extends Equatable {
  const StoreDetailState({
    this.status = StoreDetailStatus.initial,
    required this.item,
    required this.orderItems,
    this.price = 0,
    this.basketAmount = 1,
    this.magicNumber = 42,
  });

  // the current status
  final StoreDetailStatus status;

  // the initial item
  final DeliverectProductModelDto item;

  // the current price of the configured order item
  final int price;

  // the amount of items that will be added to the basket
  final int basketAmount;

  // the customized order item
  final List<CreateOrderItemDto> orderItems;

  //
  final int magicNumber;

  StoreDetailState copyWith({
    StoreDetailStatus? status,
    DeliverectProductModelDto? item,
    List<CreateOrderItemDto>? orderItems,
    int? price,
    int? basketAmount,
    int? magicNumber,
  }) {
    return StoreDetailState(
      status: status ?? this.status,
      item: item ?? this.item,
      orderItems: orderItems ?? this.orderItems,
      price: price ?? this.price,
      basketAmount: basketAmount ?? this.basketAmount,
      magicNumber: magicNumber ?? this.magicNumber,
    );
  }

  @override
  List<Object> get props => [
        item,
        price,
        status,
        basketAmount,
        orderItems,
        magicNumber,
      ];
}
