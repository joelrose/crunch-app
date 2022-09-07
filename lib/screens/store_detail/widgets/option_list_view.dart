import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickup/screens/store_detail/cubits/cubits.dart';
import 'package:pickup/screens/store_detail/widgets/option_item.dart';

class OptionListView extends StatelessWidget {
  const OptionListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _RestrictionText(),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: Border.all(
                width: 0.5,
                color: AlpacaColor.greyColor,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child:const OptionItem(),
          ),
        ],
      ),
    );
  }
}

class _RestrictionText extends StatelessWidget {
  const _RestrictionText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final optionCategory = context
        .select((ProductOptionCubit cubit) => cubit.state.optionCategory);

    final min = optionCategory.min!;
    final max = optionCategory.max!;
    final name = optionCategory.name!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: Theme.of(context).textTheme.headline3,
        ),
        if (min != 0 && max != 0)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              '(min: $min, max: $max)',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
      ],
    );
  }
}
