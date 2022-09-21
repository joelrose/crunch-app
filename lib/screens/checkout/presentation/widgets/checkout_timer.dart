import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_repository/hermes_repository.dart';
import 'package:pickup/l10n/l10n.dart';
import 'package:pickup/screens/checkout/cubits/checkout_timer_cubit/checkout_time_cubit.dart';
import 'package:pickup/screens/checkout_row_header/checkout_row_header.dart';

class CheckoutTimer extends StatelessWidget {
  CheckoutTimer({Key? key, this.availableOpenings}) : super(key: key);
  final List<GetStoreOpeningHour>? availableOpenings;

  final FixedExtentScrollController _minuteController =
      FixedExtentScrollController();
  final FixedExtentScrollController _hourController =
      FixedExtentScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutTimeCubit, CheckoutTimeState>(
      builder: (context, state) => CheckoutRowHeader(
        buttonKey: const Key('PickTimeButton'),
        header: context.l10n.pickupTime,
        buttonText: context.l10n.now,
        onPressed: () {},
        /*
        buttonText: state.pickupTime
            .formatToLocalTime(Localizations.localeOf(context).languageCode),
        onPressed: () {},
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
                child: PickUpTimeBottomSheet(
                  startingMinute: state.currentSelectedMinuteIndex,
                  startingHour: state.availableOpeningTimes
                      .indexOf(state.currentSelectedHour),
                  hourController: _hourController,
                  minuteController: _minuteController,
                ),
              );
            },
          );
        },*/
      ),
    );
  }
}
/*
class PickUpTimeBottomSheet extends StatefulWidget {
  const PickUpTimeBottomSheet({
    Key? key,
    required this.hourController,
    required this.minuteController,
    required this.startingHour,
    required this.startingMinute,
  }) : super(key: key);

  final FixedExtentScrollController hourController;
  final FixedExtentScrollController minuteController;
  final int startingMinute;
  final int startingHour;

  @override
  State<PickUpTimeBottomSheet> createState() => _PickUpTimeBottomSheetState();
}

class _PickUpTimeBottomSheetState extends State<PickUpTimeBottomSheet> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback(initListData);
  }

  void initListData(_) {
    widget.minuteController.jumpToItem(widget.startingMinute);
    widget.hourController.jumpToItem(widget.startingHour);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<CheckoutTimeCubit, CheckoutTimeState>(
        builder: (context, stateSheet) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 150,
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(color: AlpacaColor.greyColor),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: NotificationListener(
                        onNotification: (n) {
                          if (n is ScrollEndNotification) {
                            Future.delayed(Duration.zero, () {
                              widget.hourController.animateToItem(
                                widget.hourController.selectedItem,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeOut,
                              );
                            });
                          }
                          return false;
                        },
                        child: ListWheelScrollView(
                          controller: widget.hourController,
                          restorationId: 'minutes',
                          squeeze: 0.75,
                          onSelectedItemChanged: (value) {
                            final newHour =
                                stateSheet.availableOpeningTimes[value];
                            final oldMinuteValue = stateSheet
                                .currentSelectedHour
                                .minutes[stateSheet.currentSelectedMinuteIndex];
                            final newMinuteIndex =
                                newHour.minutes.indexOf(oldMinuteValue);
                            context
                                .read<CheckoutTimeCubit>()
                                .updateCurrentSelectedHour(
                                  value,
                                );

                            widget.minuteController.jumpToItem(newMinuteIndex);
                          },
                          itemExtent: 40,
                          children: List.generate(
                            stateSheet.availableOpeningTimes.length,
                            (index) => Text(
                              stateSheet.availableOpeningTimes[index].hour
                                  .toString(),
                              style: TextStyle(
                                fontSize: 40,
                                color: stateSheet.currentSelectedHour.hour ==
                                        stateSheet
                                            .availableOpeningTimes[index].hour
                                    ? AlpacaColor.primary100
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Text(
                      ':',
                      style: TextStyle(
                        fontSize: 40,
                        color: AlpacaColor.primary100,
                      ),
                    ),
                    Expanded(
                      child: NotificationListener(
                        onNotification: (n) {
                          if (n is ScrollEndNotification) {
                            Future.delayed(Duration.zero, () {
                              widget.minuteController.animateToItem(
                                widget.minuteController.selectedItem,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeOut,
                              );
                            });
                          }
                          return false;
                        },
                        child: ListWheelScrollView(
                          key: const Key('MinuteScrollView'),
                          restorationId: 'min',
                          controller: widget.minuteController,
                          squeeze: 0.75,
                          onSelectedItemChanged: (value) {
                            context
                                .read<CheckoutTimeCubit>()
                                .updateCurrentSelectedMinute(value);
                          },
                          itemExtent: 40,
                          children: List.generate(
                            stateSheet.currentSelectedHour.minutes.length,
                            (index) => Text(
                              stateSheet.currentSelectedHour.minutes[index]
                                  .toString(),
                              style: TextStyle(
                                fontSize: 40,
                                color: stateSheet.currentSelectedMinuteIndex ==
                                        index
                                    ? AlpacaColor.primary100
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 52,
                        child: ActionButton(
                          buttonText: 'Fertig',
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 20),
                        height: 52,
                        child: ActionButton(
                          buttonText: 'Jetzt',
                          onPressed: () {
                            final now = kDebugMode
                                ? DateTime(2022, 5, 12, 11, 23)
                                : DateTime.now();
                            final hour =
                                stateSheet.availableOpeningTimes.indexWhere(
                              (element) => element.hour == now.hour,
                            );

                            final minute = stateSheet
                                .currentSelectedHour.minutes
                                .indexOf(now.minute);

                            context
                                .read<CheckoutTimeCubit>()
                                .updateCurrentSelectedHour(hour);
                            context
                                .read<CheckoutTimeCubit>()
                                .updateCurrentSelectedMinute(minute);
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
*/