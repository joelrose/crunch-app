import 'dart:async';

import 'package:alpaca/alpaca.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  late Timer updateEvery30Seconds;
  late FixedExtentScrollController hourController;
  late FixedExtentScrollController minuteController;

  late DateTime initialDateTime;

  String pickupHour = DateFormat.H().format(DateTime.now()).padLeft(2, '0');
  String pickupMinute = DateFormat.m().format(DateTime.now()).padLeft(2, '0');
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
    final String currentMinute =
        DateFormat.m().format(DateTime.now().add(const Duration(minutes: 20)));
    final List<String> copyMinuteList = List.from(updatedMinuteList);
    if (hourIndex == 0 && minute <= 55) {
      for (final time in List<String>.from(copyMinuteList)) {
        if (int.parse(time) < int.parse(currentMinute)) {
          copyMinuteList.remove(time);
          if (minuteController.hasClients) minuteController.jumpTo(0);
        }
      }
      setState(() {
        updatedMinuteList = List.from(copyMinuteList);
        minuteController = FixedExtentScrollController();
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
    setState(() {
      pickupHour = hourList[newHourIndex];
      pickupMinute = updatedMinuteList[newMinuteIndex];
      hourController = FixedExtentScrollController(
        initialItem: newHourIndex,
      );
      minuteController = FixedExtentScrollController(
        initialItem: newMinuteIndex,
      );
    });
    final now = DateTime.now();
    final DateTime pickupTime = DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(pickupHour),
      int.parse(pickupMinute),
    );
    widget.getPickupTime(pickupTime);
  }

  void jumpToNextHour(int minute) {
    if (minute > 55 && initialDateTime.hour.toString() == hourList[0]) {
      hourList.removeAt(0);
    }
  }

  void updateHourAndMinute(int minute) {
    jumpToNextHour(minute);
    updateMinuteList(hourSelectedIndex, minute);
  }

  int roundUp5MinInterval(int minute) {
    final int lastDigit = minute % 10;
    if (lastDigit != 0 || lastDigit != 5) {
      final int roundedMinuteSolution = minute + 5 - (lastDigit % 5);
      return roundedMinuteSolution;
    } else {
      return minute;
    }
  }

  int getIndexOfMinute(int minute) {
    final double index = roundUp5MinInterval(minute) / 5;
    return index.toInt();
  }

  @override
  void initState() {
    super.initState();
    updatedMinuteList = List.from(minuteList);
    initialDateTime = DateTime.now().add(const Duration(minutes: 20));
    hourSelectedIndex = 0;
    minuteSelectedIndex = 0;
    minuteController = FixedExtentScrollController();
    hourController = FixedExtentScrollController();

    removePastHours(hourList);
    updateHourAndMinute(initialDateTime.minute);

    updateEvery30Seconds = Timer.periodic(const Duration(seconds: 30), (timer) {
      if (!mounted) return;
      setState(() {
        initialDateTime = DateTime.now();
        updateHourAndMinute(initialDateTime.minute);
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
          buttonText: '$pickupHour:$pickupMinute',
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
                                            initialDateTime.minute,
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
