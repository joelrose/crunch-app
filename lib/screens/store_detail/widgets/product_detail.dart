import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickup/screens/store_detail/cubit/store_detail_cubit.dart';
import 'package:pickup/shared/utilities.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final item = context.select((StoreDetailCubit cubit) => cubit.state.item);

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(
            context,
            name: item.name!,
            price: item.price!,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            item.description!,
            style: Theme.of(context).textTheme.headline5,
          )
        ],
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context, {
    required String name,
    required int price,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Text(
            name,
            style: Theme.of(context)
                .textTheme
                .headline2!
                .merge(const TextStyle(fontSize: 22)),
          ),
        ),
        Text(
          Utilities.currencyFormat(price),
          style: Theme.of(context).textTheme.headline2!.copyWith(
                color: AlpacaColor.primary100,
              ),
        )
      ],
    );
  }
}
