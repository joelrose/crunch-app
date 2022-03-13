part of 'store_detail_cubit.dart';

abstract class StoreDetailState extends Equatable {
  const StoreDetailState();

  @override
  List<Object> get props => [];
}

class StoreDetailReload extends StoreDetailState {
  const StoreDetailReload(this.data, this.price, this.magicNumber);

  final ProductDetailsData data;
  final int magicNumber;
  final int price;

  @override
  List<Object> get props => [data, price, magicNumber];
}
