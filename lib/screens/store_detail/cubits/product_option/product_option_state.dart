part of 'product_option_cubit.dart';

class ProductOptionState extends Equatable {
  const ProductOptionState({
    required this.index,
    required this.optionCategory,
  });

  final int index;
  final DeliverectProductModelDto optionCategory;

  @override
  List<Object> get props => [index, optionCategory];
}
