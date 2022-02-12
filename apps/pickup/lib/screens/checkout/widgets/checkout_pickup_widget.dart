import 'dart:async';

import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pickup/screens/checkout/widgets/checkout_main_widget.dart';
import 'package:pickup/screens/checkout/widgets/divider_widget.dart';

class CheckoutPickupWidget extends StatefulWidget {
  const CheckoutPickupWidget({Key? key, required this.getPickupTime})
      : super(key: key);
  final Function getPickupTime;

  @override
  State<CheckoutPickupWidget> createState() => _CheckoutPickupWidgetState();
}

class _CheckoutPickupWidgetState extends State<CheckoutPickupWidget> {
  int minuteWaitTime = 20;
  int minuteInterval = 5;

  late int earliestMinutePickup; 

  late List<int> hourList;
  late List<int> minuteList;

  late Timer updateEverySecond;
  late FixedExtentScrollController hourController;
  late FixedExtentScrollController minuteController;

  late DateTime pickupTime;
  late String waitTime;

  late int pickupHour;
  late int pickupMinute;
  late int hourSelectedIndex;
  late int minuteSelectedIndex;

  late List<int> updatedMinuteList;

  @override
  void initState() {
    super.initState();
    hourList = [
      for (var i = 00; i < 24; i++) i,
    ];
    minuteList = [
      for (var i = 00; i < 60; i += minuteInterval) i,
    ];
    earliestMinutePickup = getEarliestMinutePickup();
    updatedMinuteList = List.from(minuteList);
    pickupTime = getRoundedPickupTime(
      DateTime.now().add(Duration(minutes: minuteWaitTime)),
    );
    pickupHour = pickupTime.hour;
    pickupMinute = pickupTime.minute;
    waitTime = getWaitTime(
      DateTime.now().minute,
      DateTime.now().hour,
      pickupTime,
    );
    hourSelectedIndex = 0;
    minuteSelectedIndex = 0;
    minuteController = FixedExtentScrollController();
    hourController = FixedExtentScrollController();

    removePastHours(hourList);
    updateHourAndMinute(
      earliestMinutePickup,
    );

    updateEverySecond = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() {
        updateHourAndMinute(
          pickupTime.minute,
        );
        earliestMinutePickup = earliestMinutePickup = getEarliestMinutePickup();
      });
    });
  }

  int getEarliestMinutePickup() {
    final int initialMinute =
        DateTime.now().add(Duration(minutes: minuteWaitTime)).minute;
    if (initialMinute > 60) {
      return initialMinute - 60;
    }
    if (initialMinute > 55 && initialMinute <= 60) {
      return 0;
    }
    return initialMinute;
  }

  // Not in use right now
  bool checkIfPickUpTimeValid(DateTime pickUpTime) {
    final DateTime earliestMinutePickup =
        DateTime.now().add(Duration(minutes: minuteWaitTime));
    if (pickupTime.isAfter(earliestMinutePickup)) {
      return true;
    } else {
      return false;
    }
  }

  void removePastHours(List<int> timeList) {
    final currentHour = DateTime.now().hour;
    for (final time in List<int>.from(timeList)) {
      if (time < currentHour) {
        timeList.remove(time);
      }
    }
  }

  void updateMinuteList(int hourIndex, int minute) {
    final List<int> copyMinuteList = List.from(updatedMinuteList);
    if (hourIndex == 0 &&
        earliestMinutePickup <= 55 &&
        earliestMinutePickup != 0) {
      for (final minuteFromList in List<int>.from(copyMinuteList)) {
        if (minuteFromList < earliestMinutePickup) {
          copyMinuteList.remove(minuteFromList);
          if (minuteController.hasClients) minuteController.jumpTo(0);
        }
      }
      setState(() {
        updatedMinuteList = List.from(copyMinuteList);
        minuteController = FixedExtentScrollController(
          initialItem: getIndexOfMinute(
            updatedMinuteList,
            pickupTime,
          ),
        );
      });
    } else {
      setState(() {
        updatedMinuteList = List.from(minuteList);
      });
    }
  }

  void setPickUpTime(
    int newHourIndex,
    int newMinuteIndex,
  ) {
    final now = DateTime.now();
    setState(() {
      pickupHour = hourList[newHourIndex];
      pickupMinute = updatedMinuteList[newMinuteIndex];
      hourController = FixedExtentScrollController(
        initialItem: newHourIndex,
      );
      minuteController = FixedExtentScrollController(
        initialItem: newMinuteIndex,
      );
      pickupTime = DateTime(
        now.year,
        now.month,
        now.day,
        pickupHour,
        pickupMinute,
      );
      waitTime = getWaitTime(
        DateTime.now().minute,
        DateTime.now().hour,
        pickupTime,
      );
    });
    widget.getPickupTime(pickupTime);
  }

  void jumpToNextHour() {
    if (earliestMinutePickup > 55 && DateTime.now().hour == hourList[0] ||
        earliestMinutePickup < DateTime.now().minute &&
            DateTime.now().hour == hourList[0]) {
      hourList.removeAt(0);
    }
  }

  void updateHourAndMinute(int minute) {
    jumpToNextHour();
    updateMinuteList(hourSelectedIndex, minute);
  }

  void onHourChange(int itemIndex) {
    setState(() {
      hourSelectedIndex = itemIndex;
    });
    updateMinuteList(
      hourSelectedIndex,
      pickupTime.minute,
    );
  }

  void onMinuteChange(int itemIndex) {
    setState(() {
      minuteSelectedIndex = itemIndex;
    });
  }

  DateTime getRoundedPickupTime(DateTime dateTime) {
    final int minute = roundUp5MinInterval(dateTime.minute);
    final now = DateTime.now();
    final DateTime roundedPickupTime = DateTime(
      now.year,
      now.month,
      now.day,
      dateTime.hour,
      minute,
    );
    return roundedPickupTime;
  }

  int roundUp5MinInterval(int minute) {
    final int lastDigit = minute % 10;
    if (lastDigit != 0 && lastDigit != 5) {
      final int roundedMinuteSolution = minute + 5 - (lastDigit % 5);
      return roundedMinuteSolution;
    } else {
      return minute;
    }
  }

  int getIndexOfMinute(List<int> updatedMinuteList, DateTime pickupTime) {
    final int minuteIndex =
        updatedMinuteList.indexWhere((minute) => minute == pickupTime.minute);
    return minuteIndex;
  }

  int getIndexOfHour(DateTime pickupTime) {
    final int hourIndex =
        hourList.indexWhere((hour) => hour == pickupTime.hour);
    return hourIndex;
  }

  void setIndexesRight() {
    if (pickupTime.hour >= hourList[0]) {
      setState(() {
        hourSelectedIndex = getIndexOfHour(pickupTime);
        minuteSelectedIndex = getIndexOfMinute(updatedMinuteList, pickupTime);
      });
    } else {
      hourSelectedIndex = 0;
      minuteSelectedIndex = 0;
    }
  }

  String getWaitTime(int currentMinute, int currentHour, DateTime pickupTime) {
    if (currentHour < pickupTime.hour) {
      final int multipleHour = pickupTime.hour - currentHour;
      return (60 * multipleHour - currentMinute + pickupTime.minute).toString();
    } else {
      return (pickupTime.minute - currentMinute).toString();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyText1?.copyWith(
          color: AlpacaColor.darkNavyColor,
          fontSize: 42,
          fontWeight: FontWeight.w500,
        );

    final String pickupHourString = pickupHour.toString().padLeft(2, '0');
    final String pickupMinuteString = pickupMinute.toString().padLeft(2, '0');

    return Column(
      children: [
        const DividerWidget(),
        CheckoutHeaderRowWidget(
          header: 'Pickup',
          buttonText: '$pickupHourString:$pickupMinuteString ($waitTime min)',
          icon: SvgPicture.asset(
            'assets/icons/editPen.svg',
            color: AlpacaColor.primary100,
            height: 14,
            width: 14,
          ),
          onPressed: () {
            setIndexesRight();
            showModalBottomSheet(
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              context: context,
              builder: (context) {
                return StatefulBuilder(
                  builder: (context, setState) {
                    return ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 24),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Pickup time',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline2
                                          ?.copyWith(
                                            color: AlpacaColor.darkNavyColor,
                                          ),
                                    ),
                                    AlpacaClosePopUpWindownButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: AlpacaColor.greyColor,
                                  ),
                                ),
                                height: 151,
                                width: double.infinity,
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: ListWheelScrollView.useDelegate(
                                        controller: hourController,
                                        onSelectedItemChanged: (itemIndex) {
                                          setState(() {
                                            onHourChange(itemIndex);
                                          });
                                        },
                                        overAndUnderCenterOpacity: 0.2,
                                        physics:
                                            const FixedExtentScrollPhysics(),
                                        itemExtent: 50,
                                        childDelegate:
                                            ListWheelChildListDelegate(
                                          children: <Widget>[
                                            for (var hour in hourList)
                                              Text(
                                                hour.toString().padLeft(2, '0'),
                                                style: textStyle,
                                              )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Text(
                                      ':',
                                      style: textStyle,
                                    ),
                                    Flexible(
                                      child: ListWheelScrollView.useDelegate(
                                        controller: minuteController,
                                        onSelectedItemChanged: (itemIndex) {
                                          onMinuteChange(itemIndex);
                                        },
                                        overAndUnderCenterOpacity: 0.2,
                                        physics:
                                            const FixedExtentScrollPhysics(),
                                        itemExtent: 50,
                                        childDelegate:
                                            ListWheelChildListDelegate(
                                          children: <Widget>[
                                            for (var minute
                                                in updatedMinuteList)
                                              Text(
                                                minute
                                                    .toString()
                                                    .padLeft(2, '0'),
                                                style: textStyle,
                                              )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: ActionButton(
                                  buttonText: 'Done',
                                  onPressed: () {
                                    setPickUpTime(
                                      hourSelectedIndex,
                                      minuteSelectedIndex,
                                    );
                                    Navigator.pop(context);
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            );
          },
        ),
        const DividerWidget(),
      ],
    );
  }
}
