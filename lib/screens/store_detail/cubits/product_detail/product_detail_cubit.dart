import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_repository/hermes_repository.dart';
import 'package:pickup/screens/store_detail/store_detail.dart';

part 'product_detail_state.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  ProductDetailCubit({
    required StoreDetailCubit storeDetailCubit,
    required GetStoreProduct category,
    required int optionIndex,
    required int categoryIndex,
  })  : _category = category,
        _optionIndex = optionIndex,
        _categoryIndex = categoryIndex,
        _categoryOptions = category.products!,
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
  final List<GetStoreProduct> _categoryOptions;

  // category of the option item
  final GetStoreProduct _category;

  // orderItem index of the current category
  final int _categoryIndex;

  // index of the current category item in the StoreDetailCubit orderItem
  final int _optionIndex;

  void _setup(List<OrderItem> orderItems) {
    final value = _categoryOptions.elementAt(_optionIndex);

    final orderDto = orderItems[_categoryIndex].subItems!;

    final isRadio = _category.min == 1 && _category.max == 1;
    final isSnoozed = value.snoozed!;
    final isSelected = orderDto.indexWhere(
          (element) => element.plu == value.plu!,
        ) !=
        -1;

    emit(
      state.copyWith(
        status: ProductDetailStatus.reloading,
        isRadio: isRadio,
        isSnoozed: isSnoozed,
        isSelected: isSelected,
        item: value,
        orderDto: orderDto,
      ),
    );
  }

  void onTappedRadio() {
    final value = _categoryOptions.elementAt(_optionIndex);

    final newItem = OrderItem(
      name: value.name,
      price: value.price,
      plu: value.plu,
      quantity: 1,
    );

    _storeDetailCubit.addRadioOrderItem(_categoryIndex, newItem);
  }

  void onTappedCheckBox() {
    final value = _categoryOptions.elementAt(_optionIndex);

    final item = OrderItem(
      name: value.name,
      price: value.price,
      plu: value.plu,
      quantity: 1,
      subItems: [],
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
