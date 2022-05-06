import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_repository/hermes_repository.dart';
import 'package:pickup/l10n/l10n.dart';
import 'package:pickup/screens/checkout/cubits/checkout_timer_cubit/checkout_time_cubit.dart';
import 'package:pickup/screens/checkout/util/extensions.dart';
import 'package:pickup/screens/checkout_row_header/checkout_row_header.dart';

class CheckoutTimer extends StatelessWidget {
  const CheckoutTimer({Key? key, this.availableOpenings}) : super(key: key);
  final List<DeliverectAvailabilityModel>? availableOpenings;

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
              builder: (ctx) {
                return BlocProvider.value(
                  value: BlocProvider.of<CheckoutTimeCubit>(context),
                  child: BlocBuilder<CheckoutTimeCubit, CheckoutTimeState>(
                      builder: (context, stateSheet) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 150,
                          margin: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                            bottom: 50,
                            top: 20,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: AlpacaColor.greyColor),
                          ),
                          child: Row(
                            children: [
                              _CustomListViewScrollWheel(
                                onSelectedItemChanged: (int value) {
                                  context
                                      .read<CheckoutTimeCubit>()
                                      .updateCurrentSelectedHour(value);
                                },
                                children: List.generate(
                                  stateSheet.availableOpeningTimes.length,
                                  (index) => Text(
                                    stateSheet.availableOpeningTimes[index].hour
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: 40,
                                      color: stateSheet
                                                  .currentSelectedHour.hour ==
                                              stateSheet
                                                  .availableOpeningTimes[index]
                                                  .hour
                                          ? AlpacaColor.primary100
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                              const Text(
                                ':',
                                style: TextStyle(fontSize: 40),
                              ),
                              _CustomListViewScrollWheel(
                                onSelectedItemChanged: (int value) {
                                  context
                                      .read<CheckoutTimeCubit>()
                                      .updateCurrentSelectedMinute(value);
                                },
                                children: List.generate(
                                  stateSheet.currentSelectedHour.minutes.length,
                                  (index) => Text(
                                    stateSheet
                                        .currentSelectedHour.minutes[index]
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: 40,
                                      color: stateSheet
                                                  .currentSelectedMinuteIndex ==
                                              index
                                          ? AlpacaColor.primary100
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: 200,
                          child: ActionButton(
                              buttonText: 'Fertig', onPressed: () {}),
                        )
                      ],
                    );
                  }),
                );
              });
        },
      ),
    );
  }
}

class _CustomListViewScrollWheel extends StatelessWidget {
  _CustomListViewScrollWheel(
      {Key? key, required this.children, required this.onSelectedItemChanged})
      : super(key: key);
  final List<Widget> children;
  final Function(int value) onSelectedItemChanged;

  final FixedExtentScrollController _scrollController =
      FixedExtentScrollController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: NotificationListener(
        onNotification: (n) {
          if (n is ScrollEndNotification) {
            Future.delayed(Duration.zero, () {
              _scrollController.animateToItem(_scrollController.selectedItem,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut);
            });
          }
          return false;
        },
        child: ListWheelScrollView(
            controller: _scrollController,
            squeeze: 0.75,
            onSelectedItemChanged: onSelectedItemChanged,
            itemExtent: 40,
            children: children),
      ),
    );
  }
}
