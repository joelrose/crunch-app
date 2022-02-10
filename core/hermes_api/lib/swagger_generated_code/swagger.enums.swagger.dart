import 'package:json_annotation/json_annotation.dart';

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
