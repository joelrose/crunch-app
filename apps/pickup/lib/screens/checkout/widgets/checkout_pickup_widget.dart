import 'dart:async';

import 'package:alpaca/alpaca.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:pickup/screens/checkout/widgets/checkout_main_widget.dart';
import 'package:pickup/screens/checkout/widgets/divider_widget.dart';

class CheckoutPickupWidget extends StatefulWidget {
  const CheckoutPickupWidget({Key? key, this.getPickupTime}) : super(key: key);
  final getPickupTime;

  @override
  State<CheckoutPickupWidget> createState() => _CheckoutPickupWidgetState();
}

class _CheckoutPickupWidgetState extends State<CheckoutPickupWidget> {
  int minuteWaitTime = 20;

  late Timer updateEvery30Seconds;
  late FixedExtentScrollController hourController;
  late FixedExtentScrollController minuteController;

  late DateTime pickupTime;
  late String waitTime;

  late String pickupHour;
  late String pickupMinute;
  late int hourSelectedIndex;
  late int minuteSelectedIndex;

  List<String> hourList = [
    for (var i = 00; i < 24; i++) i.toString().padLeft(2, '0'),
  ];
  List<String> minuteList = [
    for (var i = 00; i < 60; i += 5) i.toString().padLeft(2, '0')
  ];
  late List<String> updatedMinuteList;

  void removePastHours(List<String> timeList) {
    final String currentHour = DateFormat.H().format(DateTime.now());
    for (final time in List<String>.from(timeList)) {
      if (int.parse(time) < int.parse(currentHour)) {
        timeList.remove(time);
      }
    }
  }

  void updateMinuteList(int hourIndex, int minute) {
    final String minimalMinuteForPickup = DateFormat.m()
        .format(DateTime.now().add(Duration(minutes: minuteWaitTime)));
    final List<String> copyMinuteList = List.from(updatedMinuteList);
    if (hourIndex == 0 && minute <= 55 && minute != 0) {
      for (final time in List<String>.from(copyMinuteList)) {
        if (int.parse(time) < int.parse(minimalMinuteForPickup)) {
          copyMinuteList.remove(time);
          if (minuteController.hasClients) minuteController.jumpTo(0);
        }
      }
      setState(() {
        updatedMinuteList = List.from(copyMinuteList);
        minuteController =
            FixedExtentScrollController(initialItem: getIndexOfMinute(minute));
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
        int.parse(pickupHour),
        int.parse(pickupMinute),
      );
      waitTime = getWaitTime(
        DateTime.now().minute,
        pickupTime.minute,
      );
    });
    widget.getPickupTime(pickupTime);
  }

  void jumpToNextHour(int minute) {
    if (minute > 55 && DateTime.now().hour.toString() == hourList[0] ||
        minute < DateTime.now().minute &&
            DateTime.now().hour.toString() == hourList[0]) {
      hourList.removeAt(0);
    }
  }

  void updateHourAndMinute(int minute) {
    jumpToNextHour(minute);
    updateMinuteList(hourSelectedIndex, minute);
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

  int getIndexOfMinute(int minute) {
    final String roundedMinute = roundUp5MinInterval(minute).toString();
    int index = 0;
    for (final minute in updatedMinuteList) {
      if (minute == roundedMinute) {
        return index;
      } else {
        index++;
      }
    }
    return 0;
  }

  String getWaitTime(int currentMinute, int pickupMinute) {
    if (currentMinute > pickupMinute) {
      final int multipleHour = pickupTime.hour - DateTime.now().hour;
      return (60 * multipleHour - currentMinute + pickupMinute).toString();
    } else {
      return (pickupMinute - currentMinute).toString();
    }
  }

  @override
  void initState() {
    super.initState();
    updatedMinuteList = List.from(minuteList);
    pickupTime = getRoundedPickupTime(
      DateTime.now().add(Duration(minutes: minuteWaitTime)),
    );
    pickupHour = pickupTime.hour.toString().padLeft(2, '0');
    pickupMinute = pickupTime.minute.toString().padLeft(2, '0');
    waitTime = getWaitTime(
      DateTime.now().minute,
      pickupTime.minute,
    );
    hourSelectedIndex = 0;
    minuteSelectedIndex = 0;
    minuteController = FixedExtentScrollController();
    hourController = FixedExtentScrollController();

    removePastHours(hourList);
    updateHourAndMinute(
      DateTime.now().add(Duration(minutes: minuteWaitTime)).minute,
    );

    updateEvery30Seconds = Timer.periodic(const Duration(seconds: 30), (timer) {
      if (!mounted) return;
      setState(() {
        updateHourAndMinute(
          pickupTime.minute,
        );
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyText1?.merge(
          const TextStyle(
            color: AlpacaColor.darkNavyColor,
            fontSize: 44,
            fontWeight: FontWeight.normal,
          ),
        );

    return Column(
      children: [
        const DividerWidget(),
        CheckoutHeaderRowWidget(
          header: 'Pickup',
          buttonText: '$pickupHour:$pickupMinute ($waitTime min)',
          icon: SvgPicture.asset(
            'assets/icons/editPen.svg',
            color: AlpacaColor.primary100,
            height: 14,
            width: 14,
          ),
          onPressed: () {
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
                                            fontSize: 22,
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
                                            hourSelectedIndex = itemIndex;
                                          });
                                          updateMinuteList(
                                            hourSelectedIndex,
                                            pickupTime.minute,
                                          );
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
                                                hour,
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
                                          setState(() {
                                            minuteSelectedIndex = itemIndex;
                                          });
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
                                                minute,
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
