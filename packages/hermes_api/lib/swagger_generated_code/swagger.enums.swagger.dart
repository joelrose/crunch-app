import 'package:json_annotation/json_annotation.dart';

enum DeliverectDay {
  @JsonValue('swaggerGeneratedUnknown')
  swaggerGeneratedUnknown,
  @JsonValue('Monday')
  monday,
  @JsonValue('Tuesday')
  tuesday,
  @JsonValue('Wednesday')
  wednesday,
  @JsonValue('Thursday')
  thursday,
  @JsonValue('Friday')
  friday,
  @JsonValue('Saturday')
  saturday,
  @JsonValue('Sunday')
  sunday
}

// TODO: fixed manually
const $DeliverectDayMap = {
  DeliverectDay.monday: '1',
  DeliverectDay.tuesday: '2',
  DeliverectDay.wednesday: '3',
  DeliverectDay.thursday: '4',
  DeliverectDay.friday: '5',
  DeliverectDay.saturday: '6',
  DeliverectDay.sunday: '7'
};

enum DeliverectOrderTypes {
  @JsonValue('swaggerGeneratedUnknown')
  swaggerGeneratedUnknown,
  @JsonValue('PICKUP')
  pickup,
  @JsonValue('DELIVERY')
  delivery,
  @JsonValue('EAT_IN')
  eatIn,
  @JsonValue('CURBSIDE')
  curbside
}

const $DeliverectOrderTypesMap = {
  DeliverectOrderTypes.pickup: 'PICKUP',
  DeliverectOrderTypes.delivery: 'DELIVERY',
  DeliverectOrderTypes.eatIn: 'EAT_IN',
  DeliverectOrderTypes.curbside: 'CURBSIDE'
};

enum OrderStatus {
  @JsonValue('swaggerGeneratedUnknown')
  swaggerGeneratedUnknown,
  @JsonValue('Ordered')
  ordered,
  @JsonValue('Paid')
  paid,
  @JsonValue('Declined')
  declined,
  @JsonValue('Confirmed')
  confirmed,
  @JsonValue('Done')
  done
}

const $OrderStatusMap = {
  OrderStatus.ordered: 'Ordered',
  OrderStatus.paid: 'Paid',
  OrderStatus.declined: 'Declined',
  OrderStatus.confirmed: 'Confirmed',
  OrderStatus.done: 'Done'
};

enum TokenDevice {
  @JsonValue('swaggerGeneratedUnknown')
  swaggerGeneratedUnknown,
  @JsonValue('IOS')
  ios,
  @JsonValue('Android')
  android
}

const $TokenDeviceMap = {
  TokenDevice.ios: 'IOS',
  TokenDevice.android: 'Android'
};
