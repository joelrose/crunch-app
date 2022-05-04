part of 'store_detail_cubit.dart';

enum StoreDetailStatus { initial, reloading, done }

class StoreDetailState extends Equatable {
  const StoreDetailState({
    this.status = StoreDetailStatus.initial,
    required this.item,
    required this.checkoutItems,
    this.price = 0,
  });

  final StoreDetailStatus status;
  final DeliverectProductModelDto item;
  final List<CreateOrderItemDto> checkoutItems;
  final int price;

  StoreDetailState copyWith({
    StoreDetailStatus? status,
    DeliverectProductModelDto? item,
    List<CreateOrderItemDto>? checkoutItems,
    int? price,
  }) {
    return StoreDetailState(
      status: status ?? this.status,
      checkoutItems: checkoutItems ?? this.checkoutItems,
      item: item ?? this.item,
      price: price ?? this.price,
    );
  }

  @override
  List<Object> get props => [item, checkoutItems, price, status];
}
