import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickup/screens/store_detail/cubit/store_detail_cubit.dart';
import 'package:pickup/screens/store_detail/view/store_detail_view.dart';
import 'package:pickup/shared/models/product_detail_model.dart';

class StoreDetailPage extends StatelessWidget {
  const StoreDetailPage({Key? key, required this.data}) : super(key: key);

  static const route = '/store/product';

  final ProductDetailsData data;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StoreDetailCubit(data),
      child: StoreDetailView(
        image: data.restaurantImage,
      ),
    );
  }
}
