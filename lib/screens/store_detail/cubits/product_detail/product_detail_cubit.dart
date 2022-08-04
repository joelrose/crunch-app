import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_repository/hermes_repository.dart';
import 'package:pickup/screens/store_detail/store_detail.dart';

part 'product_detail_state.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  ProductDetailCubit({
    required StoreDetailCubit storeDetailCubit,
    required DeliverectProductModelDto category,
    required int optionIndex,
    required int categoryIndex,
  })  : _category = category,
        _optionIndex = optionIndex,
        _categoryIndex = categoryIndex,
        _categoryOptions = category.childProducts!,
        _storeDetailCubit = storeDetailCubit,
        super(const ProductDetailState()) {
    _setup(storeDetailCubit.state.orderItems);

    _orderItemsSubscription = storeDetailCubit.stream.listen((state) {
      _setup(state.orderItems);
    });
  }

  @override
  Future<void> close() {
    _orderItemsSubscription.cancel();
    return super.close();
  }

  late final StreamSubscription _orderItemsSubscription;

  final StoreDetailCubit _storeDetailCubit;

  // _category.childProducts!
  final List<ProductRelationModelDto> _categoryOptions;

  // category of the option item
  final DeliverectProductModelDto _category;

  // orderItem index of the current category
  final int _categoryIndex;

  // index of the current category item in the StoreDetailCubit orderItem
  final int _optionIndex;

  void _setup(List<CreateOrderItemDto> orderItems) {
    final _value = _categoryOptions.elementAt(_optionIndex).childProduct!;

    final orderDto = orderItems[_categoryIndex].items!;

    final isRadio = _category.min == 1 && _category.max == 1;
    final isSnoozed = _value.snoozed!;
    final isSelected = orderDto.indexWhere(
          (element) => element.plu == _value.plu!,
        ) !=
        -1;

    emit(
      state.copyWith(
        status: ProductDetailStatus.reloading,
        isRadio: isRadio,
        isSnoozed: isSnoozed,
        isSelected: isSelected,
        item: _value,
        orderDto: orderDto,
      ),
    );
  }

  void onTappedRadio() {
    final value = _categoryOptions.elementAt(_optionIndex).childProduct!;

    final newItem = CreateOrderItemDto(
      name: value.name,
      price: value.price,
      plu: value.plu,
      quantity: 1,
    );

    _storeDetailCubit.addRadioOrderItem(_categoryIndex, newItem);
  }

  void onTappedCheckBox() {
    final value = _categoryOptions.elementAt(_optionIndex).childProduct!;

    final item = CreateOrderItemDto(
      name: value.name,
      price: value.price,
      plu: value.plu,
      quantity: 1,
      items: [],
    );

    _storeDetailCubit.addCheckBoxOrderItem(_categoryIndex, item);
  }

  void onDecrease() {
    _storeDetailCubit.decreaseOrderItem(_categoryIndex, state.item!.plu);
  }

  void onIncrease() {
    _storeDetailCubit.increaseOrderItem(
      _categoryIndex,
      state.item!.plu,
      _category.multiMax!,
    );
  }

  void onTapped() {
    state.isRadio ? onTappedRadio() : onTappedCheckBox();
  }
}
