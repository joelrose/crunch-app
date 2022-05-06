import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickup/l10n/l10n.dart';
import 'package:pickup/screens/checkout/cubits/checkout_timer_cubit/checkout_time_cubit.dart';
import 'package:pickup/screens/checkout/util/extensions.dart';
import 'package:pickup/screens/checkout_row_header/checkout_row_header.dart';

class CheckoutTimer extends StatelessWidget {
  const CheckoutTimer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutTimeCubit, CheckoutTimeState>(
      builder: (context, state) => CheckoutRowHeader(
        header: context.l10n.pickupTime,
        buttonText: state.pickupTime.formatToLocalTime(context),
        onPressed: () {
          showModalBottomSheet(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            context: context,
            builder: (ctx) => BlocProvider.value(
              value: BlocProvider.of<CheckoutTimeCubit>(context),
              child: BlocBuilder<CheckoutTimeCubit, CheckoutTimeState>(
                builder: (context, stateSheet) => Container(
                  height: 150,
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 50, top: 20),
                  decoration: BoxDecoration(
                      border: Border.all(color: AlpacaColor.greyColor)),
                  child: Row(
                    children: [
                      Expanded(
                        child: ListWheelScrollView(
                          onSelectedItemChanged: (index) {
                            context
                                .read<CheckoutTimeCubit>()
                                .updateCurrentSelectedHour(index);
                          },
                          itemExtent: 60,
                          children: List.generate(
                            stateSheet.availableOpeningTimes.length,
                            (index) => Text(
                              stateSheet.availableOpeningTimes[index].hour
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 40,
                                  color: stateSheet.currentSelectedHour ==
                                          stateSheet
                                              .availableOpeningTimes[index].hour
                                      ? Colors.red
                                      : Colors.grey),
                            ),
                          ),
                        ),
                      ),
                      const Text(
                        ':',
                        style: TextStyle(fontSize: 40),
                      ),
                      Expanded(
                        child: ListWheelScrollView(
                          onSelectedItemChanged: context
                              .read<CheckoutTimeCubit>()
                              .updateCurrentSelectedMinute,
                          itemExtent: 60,
                          children: List.generate(
                            2,
                            // stateSheet
                            //     .availableOpeningTimes[
                            //         stateSheet.currentSelectedHour]!
                            //     .length,
                            (index) => Text(
                              stateSheet.availableOpeningTimes[
                                      stateSheet.currentSelectedHour]!
                                  .toString(),
                              style: TextStyle(
                                fontSize: 40,
                                color: stateSheet.currentSelectedMinute == index
                                    ? Colors.red
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
