import 'package:alpaca/global.dart';
import 'package:alpaca/screens/checkout/widgets/checkout_main_widget.dart';
import 'package:alpaca/screens/checkout/widgets/divider_widget.dart';
import 'package:flutter/material.dart';
import 'package:alpaca/shared/buttons.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class CheckoutPickupWidget extends StatefulWidget {
  const CheckoutPickupWidget({Key? key}) : super(key: key);

  @override
  State<CheckoutPickupWidget> createState() => _CheckoutPickupWidgetState();
}

class _CheckoutPickupWidgetState extends State<CheckoutPickupWidget> {
  String pickupDate = DateFormat.MMMEd().format(DateTime.now());
  String now = DateFormat.MMMEd().format(DateTime.now());
  String pickupHourMinute =
      DateFormat.jm().format(DateTime.now().add(const Duration(minutes: 20)));
  String pickupTimeAsString = DateFormat.MMMEd()
      .add_jm()
      .format(DateTime.now().add(const Duration(minutes: 20)));
  DateTime pickupTimeAsDateTime = DateTime.now().add(
    const Duration(minutes: 20),
  );
  DateTime pickupMinTime = DateTime.now().add(const Duration(minutes: 10));

  Future<void> _changePickupTime(DateTime time) async {
    setState(() {
      pickupMinTime = DateTime.now().add(const Duration(minutes: 10));
      now = DateFormat.MMMEd().format(DateTime.now());
      pickupTimeAsDateTime = time.add(const Duration(minutes: 1));
      pickupTimeAsString = DateFormat.MMMEd().add_jm().format(time);
      pickupDate = DateFormat.MMMEd().format(time);
      pickupHourMinute = DateFormat.jm().format(time);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (pickupDate == now) {
      pickupTimeAsString = 'Today, $pickupHourMinute';
    }

    return Column(
      children: [
        const DividerWidget(),
        CheckoutHeaderRowWidget(
          header: 'Pickup',
          onPressed: () {
            DatePicker.showDateTimePicker(
              context,
              maxTime: DateTime(1, 1, 1, 18),
              minTime: pickupMinTime,
              onConfirm: (time) {
                _changePickupTime(time);
              },
              currentTime: pickupTimeAsDateTime,
            );
            // showModalBottomSheet(
            //   isScrollControlled: true,
            //   shape:
            //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            //   context: context,
            //   builder: (context) {
            //     return ListView(
            //       shrinkWrap: true,
            //       children: [
            //         Container(
            //           padding: const EdgeInsets.symmetric(horizontal: 18),
            //           child: Column(
            //             children: [
            //               Padding(
            //                 padding: const EdgeInsets.symmetric(vertical: 24),
            //                 child: Row(
            //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                   children: [
            //                     Text(
            //                       'Pickup time',
            //                       style: Theme.of(context)
            //                           .textTheme
            //                           .headline2
            //                           ?.copyWith(
            //                             fontSize: 22,
            //                             color: AlpacaColor.darkNavyColor,
            //                           ),
            //                     ),
            //                     AlpacaClosePopUpWindownButton(
            //                       onPressed: () {
            //                         Navigator.pop(context);
            //                       },
            //                     )
            //                   ],
            //                 ),
            //               ),
            //               const Placeholder(
            //                 fallbackHeight: 151,
            //                 fallbackWidth: double.infinity,
            //               ),
            //               Padding(
            //                 padding: const EdgeInsets.symmetric(vertical: 20),
            //                 child:
            //                     ActionButton(buttonText: 'Done', onPressed: () {}),
            //               )
            //             ],
            //           ),
            //         ),
            //       ],
            //     );
            //   },
            // );
          },
          buttonText: pickupTimeAsString,
        ),
        const DividerWidget(),
      ],
    );
  }
}
