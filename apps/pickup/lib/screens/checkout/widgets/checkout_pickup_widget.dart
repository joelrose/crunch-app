import 'package:alpaca/alpaca.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:pickup/screens/checkout/widgets/checkout_main_widget.dart';
import 'package:pickup/screens/checkout/widgets/divider_widget.dart';

class AlpacaPicker extends CommonPickerModel {}

String pickupDate = DateFormat.MMMEd().format(DateTime.now());
String pickupHourMinute =
    DateFormat.Hm().format(DateTime.now().add(const Duration(minutes: 20)));
DateTime pickupTimeAsDateTime = DateTime.now().add(
  const Duration(minutes: 20),
);
DateTime pickupMinTime = DateTime.now().add(const Duration(minutes: 10));

class CheckoutPickupWidget extends StatefulWidget {
  CheckoutPickupWidget({Key? key}) : super(key: key);

  @override
  State<CheckoutPickupWidget> createState() => _CheckoutPickupWidgetState();
}

class _CheckoutPickupWidgetState extends State<CheckoutPickupWidget> {
  late FixedExtentScrollController hourController;
  late FixedExtentScrollController minuteController;

  DateTime initialDateTime = DateTime.now();

  String currentHour = DateFormat.H().format(DateTime.now());
  String pickupHour = DateFormat.H().format(DateTime.now());
  String pickupMinute = DateFormat.m().format(DateTime.now());
  late int hourSelectedIndex;
  late int minuteSelectedIndex;

  List<String> hourList = [
    for (var i = 00; i < 24; i++) i.toString().padLeft(2, '0'),
  ];
  List<String> minuteList = [
    for (var i = 00; i < 60; i += 5) i.toString().padLeft(2, '0')
  ];

  int removePastTime(List<String> timeList) {
    const int setIndexToFirst = 0;
    for (final time in List<String>.from(timeList)) {
      if (int.parse(time) < int.parse(currentHour)) {
        timeList.remove(time);
      }
    }
    return setIndexToFirst;
  }

  void setPickUpTime(
    int hourIndex,
    int minuteIndex,
  ) {
    setState(() {
      print(hourIndex);
      print(minuteIndex);
      pickupHour = hourList[hourIndex];
      pickupMinute = minuteList[minuteIndex];
      hourController = FixedExtentScrollController(
        initialItem: hourIndex,
      );
      minuteController = FixedExtentScrollController(
        initialItem: minuteIndex,
      );
    });
  }

  int jumpToNextHour(int minute) {
    if (minute >= 55) {
      setState(() {
        initialDateTime = initialDateTime.add(const Duration(hours: 1));
      });
      const int newMinute = 0;
      return newMinute;
    } else {
      return minute;
    }
  }

  int roundUp5MinInterval(int minute) {
    final int lastDigit = minute % 10;
    if (lastDigit != 0 || lastDigit != 5) {
      int roundedMinuteSolution = minute + 5 - (lastDigit % 5);
      return roundedMinuteSolution = jumpToNextHour(roundedMinuteSolution);
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
    removePastTime(hourList);
    initialDateTime = DateTime.now();
    hourSelectedIndex = initialDateTime.hour;
    minuteSelectedIndex = initialDateTime.minute;
    minuteController = FixedExtentScrollController(
      initialItem: getIndexOfMinute(initialDateTime.minute),
    );
    hourController = FixedExtentScrollController();
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
          buttonText: '${pickupHour}:${pickupMinute} (20 min)',
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              context: context,
              builder: (context) {
                return ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    },
                                    overAndUnderCenterOpacity: 0.2,
                                    physics: const FixedExtentScrollPhysics(),
                                    itemExtent: 50,
                                    childDelegate: ListWheelChildListDelegate(
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
                                    physics: const FixedExtentScrollPhysics(),
                                    itemExtent: 50,
                                    childDelegate: ListWheelChildListDelegate(
                                      children: <Widget>[
                                        for (var minute in minuteList)
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
                            padding: const EdgeInsets.symmetric(vertical: 20),
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
        ),
        const DividerWidget(),
      ],
    );
  }
}
