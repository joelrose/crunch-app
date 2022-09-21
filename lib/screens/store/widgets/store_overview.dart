import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickup/screens/store/cubit/store_cubit.dart';
import 'package:pickup/screens/store/widgets/store_rating.dart';
import 'package:pickup/screens/store_information/store_information.dart';

class StoreOverview extends StatelessWidget {
  const StoreOverview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = context.select((StoreCubit cubit) => cubit.state.store!);

    return TextButton(
      onPressed: () => Navigator.of(context).push(
        StoreInformationPage.route(
          store: store,
        ),
      ),
      style: TextButton.styleFrom(
        primary: AlpacaColor.primary100,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      store.name!,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        StoreRating(
                          rating: store.reviewCount.toString(),
                          reviewCount: store.reviewCount.toString(),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: AlpacaColor.greyColor80,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
