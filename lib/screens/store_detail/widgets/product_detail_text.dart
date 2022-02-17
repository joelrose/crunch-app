import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickup/screens/store_detail/cubit/store_detail_cubit.dart';

class ProductBasicDetails extends StatelessWidget {
  const ProductBasicDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreDetailCubit, StoreDetailState>(
      builder: (context, state) {
        final data = (state as StoreDetailReload).data;
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data.item.title.english,
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .merge(const TextStyle(fontSize: 22)),
                  ),
                  Text(
                    '${data.item.price.toStringAsFixed(2)} €',
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          color: AlpacaColor.primary100,
                        ),
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'Example description! Should be changed when basic details are available',
                style: Theme.of(context).textTheme.headline5,
              )
            ],
          ),
        );
      },
    );
  }
}
