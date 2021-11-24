import 'package:alpaca/alpaca.dart';
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
  String now = DateFormat.Hm().format(DateTime.now());
  String pickupHour = DateFormat.H().format(DateTime.now());
  String pickupMinute = DateFormat.m().format(DateTime.now());
  String pickupHourPlaceholder = '';
  String pickupMinutePlaceholder = '';

  List<String> hourList = [
    for (var i = 00; i < 24; i++) i.toString().padLeft(2, '0'),
  ];

  List<String> minuteList = [
    for (var i = 00; i < 60; i += 5) i.toString().padLeft(2, '0')
  ];

  void removePastTime () {
    
  }

  void reorderList(List<String> list, String item) {
    int itemIndex = list.indexWhere((listItem) => listItem == item);
    for (var i = 0; i < list.length; i++) {
      if (i < itemIndex) {
        final item = list[i];
        list.removeAt(i);
        list.add(item);
        i--;
        itemIndex--;
      }
    }
  }

  void setPickUpTime(
    String hour,
    String minute,
  ) {
    reorderList(hourList, hour);
    reorderList(minuteList, minute);
    setState(() {
      pickupHour = pickupHourPlaceholder;
      pickupMinute = pickupMinutePlaceholder;
    });
  }

  @override
  void initState() {
    super.initState();
    reorderList(hourList, pickupHour);
    reorderList(minuteList, pickupMinute);
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
                                    onSelectedItemChanged: (itemIndex) {
                                      setState(() {
                                        pickupHourPlaceholder =
                                            hourList[itemIndex];
                                      });
                                    },
                                    overAndUnderCenterOpacity: 0.2,
                                    physics: const FixedExtentScrollPhysics(),
                                    itemExtent: 50,
                                    childDelegate:
                                        ListWheelChildLoopingListDelegate(
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
                                    onSelectedItemChanged: (itemIndex) {
                                      setState(() {
                                        pickupMinutePlaceholder =
                                            minuteList[itemIndex];
                                      });
                                    },
                                    overAndUnderCenterOpacity: 0.2,
                                    physics: const FixedExtentScrollPhysics(),
                                    itemExtent: 50,
                                    childDelegate:
                                        ListWheelChildLoopingListDelegate(
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
                                  pickupHourPlaceholder,
                                  pickupMinutePlaceholder,
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
