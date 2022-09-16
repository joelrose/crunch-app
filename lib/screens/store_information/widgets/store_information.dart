import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickup/l10n/l10n.dart';
import 'package:pickup/screens/store_information/cubit/cubit.dart';
import 'package:pickup/screens/store_information/widgets/store_information_item.dart';

class StoreInformation extends StatelessWidget {
  const StoreInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.select(
      (StoreInformationCubit cubit) => cubit.state.store,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 18,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.l10n.storeInformation,
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                        color: AlpacaColor.darkNavyColor,
                      ),
                ),
              ],
            ),
          ),
          /*StoreInformationItem(
            icon: 'assets/icons/clock-opening-times.svg',
            title: context.l10n.storeOpenTimes,
            description: _getOpeningTimes(context, model.menu!.availabilities!),
          ),*/
          StoreInformationItem(
            icon: 'assets/icons/phone-store-address.svg',
            title: context.l10n.storeContactNumber,
            description: model.phoneNumber!,
          ),
          StoreInformationItem(
            icon: 'assets/icons/location-store-address.svg',
            title: context.l10n.storeAddress,
            description: model.address!,
          ),
        ],
      ),
    );
  }

  /*String _getOpeningTimes(
    BuildContext context,
    List<DeliverectAvailabilityModel> availabilities,
  ) {
    final today = DateTime.now();

    final todaysOpeningHours = availabilities
        .where(
          (element) => element.dayOfWeek!.index == today.weekday,
        )
        .toList();

    /*String openingTimes = context.l10n.closed;
    for (final hour in todaysOpeningHours) {
      final startTime = hour.startTime!.split(':');
      // final endTime = hour.startTime!.split(':');

      final startHour = int.parse(startTime[0]);
      final startMinutes = int.parse(startTime[0]);

      if (today.hour > startHour) {
        openingTimes = '${hour.startTime!} - ${hour.endTime!}';
      } else if (today.hour == startHour && today.minute < startMinutes) {
        openingTimes = '${hour.startTime!} - ${hour.endTime!}';
      }
    }

    return openingTimes;*/
  }*/
}
