import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickup/screens/store_detail/cubits/cubits.dart';
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
          _Header(
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
}

class _Header extends StatelessWidget {
  const _Header({Key? key, required this.name, required this.price})
      : super(key: key);

  final String name;
  final num price;

  @override
  Widget build(BuildContext context) {
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
