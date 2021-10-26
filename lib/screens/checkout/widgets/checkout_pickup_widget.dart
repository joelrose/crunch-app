import 'package:alpaca/global.dart';
import 'package:alpaca/screens/checkout/widgets/checkout_header_row_widget.dart';
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
  String todayDate = DateFormat.MMMEd().format(DateTime.now());
  String pickupHourMinute =
      DateFormat.jm().format(DateTime.now().add(const Duration(minutes: 20)));
  String pickupTime = DateFormat.MMMEd()
      .add_jm()
      .format(DateTime.now().add(const Duration(minutes: 20)));

  Future<void> _changePickupTime(DateTime time) async {
    setState(() {
      pickupTime = DateFormat.MMMEd().add_jm().format(time);
      pickupDate = DateFormat.MMMEd().format(time);
      pickupHourMinute = DateFormat.jm().format(time);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (pickupDate == todayDate) {
      pickupTime = 'Today, $pickupHourMinute';
    }

    return CheckoutHeaderRowWidget(
      header: 'Pickup',
      onPressed: () {
        DatePicker.showDateTimePicker(
          context,
          onConfirm: (time) {
            _changePickupTime(time);
          },
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
      buttonText: pickupTime,
    );
  }
}
