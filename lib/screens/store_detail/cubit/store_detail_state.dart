part of 'store_detail_cubit.dart';

abstract class StoreDetailState extends Equatable {
  const StoreDetailState();

  @override
  List<Object> get props => [];
}

class StoreDetailReload extends StoreDetailState {
  const StoreDetailReload(this.data, this.price);

  final ProductDetailsData data;
  final double price;

  @override
  List<Object> get props => [data, price];
}
