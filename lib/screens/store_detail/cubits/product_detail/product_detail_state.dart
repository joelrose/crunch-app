part of 'product_detail_cubit.dart';

enum ProductDetailStatus { initial, reloading }

extension ProductDetailStatusX on ProductDetailStatus {
  bool get isReloading => this == ProductDetailStatus.reloading;
  bool get isInitial => this == ProductDetailStatus.initial;
}

class ProductDetailState extends Equatable {
  const ProductDetailState({
    this.status = ProductDetailStatus.initial,
    this.isRadio = false,
    this.isSnoozed = false,
    this.isSelected = false,
    this.item,
    this.orderDto = const [],
  });

  final ProductDetailStatus status;

  final DeliverectProductModelDto? item;

  final List<CreateOrderItemDto> orderDto;

  final bool isRadio;
  final bool isSnoozed;
  final bool isSelected;

  // copyWith
  ProductDetailState copyWith({
    ProductDetailStatus? status,
    DeliverectProductModelDto? item,
    List<CreateOrderItemDto>? orderDto,
    bool? isRadio,
    bool? isSnoozed,
    bool? isSelected,
  }) {
    return ProductDetailState(
      status: status ?? this.status,
      item: item ?? this.item,
      orderDto: orderDto ?? this.orderDto,
      isRadio: isRadio ?? this.isRadio,
      isSnoozed: isSnoozed ?? this.isSnoozed,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  List<Object> get props => [
        status,
        isRadio,
        isSnoozed,
        isSelected,
        orderDto,
      ];
}
