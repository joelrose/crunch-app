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

// FIXED MANUALLY
const $DeliverectDayMap = {
  DeliverectDay.monday: '1',
  DeliverectDay.tuesday: '2',
  DeliverectDay.wednesday: '3',
  DeliverectDay.thursday: '4',
  DeliverectDay.friday: '5',
  DeliverectDay.saturday: '6',
  DeliverectDay.sunday: '7'
};

enum DeliverectOrderStatus {
  @JsonValue('swaggerGeneratedUnknown')
  swaggerGeneratedUnknown,
  @JsonValue('PARSED')
  parsed,
  @JsonValue('RECEIVED')
  received,
  @JsonValue('NEW')
  $new,
  @JsonValue('ACCEPTED')
  accepted,
  @JsonValue('DUPLICATE')
  duplicate,
  @JsonValue('PRINTED')
  printed,
  @JsonValue('PREPARING')
  preparing,
  @JsonValue('PREPARED')
  prepared,
  @JsonValue('READY_FOR_PICKUP')
  readyForPickup,
  @JsonValue('INDELIVERY')
  indelivery,
  @JsonValue('FINALIZED')
  finalized,
  @JsonValue('AUTO_FINALIZED')
  autoFinalized,
  @JsonValue('CANCEL')
  cancel,
  @JsonValue('CANCELED')
  canceled,
  @JsonValue('FAILED')
  failed,
  @JsonValue('POS_RECEIVED_FAILED')
  posReceivedFailed,
  @JsonValue('PARSE_FAILED')
  parseFailed
}

const $DeliverectOrderStatusMap = {
  DeliverectOrderStatus.parsed: '1',
  DeliverectOrderStatus.received: '2',
  DeliverectOrderStatus.$new: '10',
  DeliverectOrderStatus.accepted: '20',
  DeliverectOrderStatus.duplicate: '30',
  DeliverectOrderStatus.printed: '40',
  DeliverectOrderStatus.preparing: '50',
  DeliverectOrderStatus.prepared: '60',
  DeliverectOrderStatus.readyForPickup: '70',
  DeliverectOrderStatus.indelivery: '80',
  DeliverectOrderStatus.finalized: '90',
  DeliverectOrderStatus.autoFinalized: '95',
  DeliverectOrderStatus.cancel: '100',
  DeliverectOrderStatus.canceled: '110',
  DeliverectOrderStatus.failed: '120',
  DeliverectOrderStatus.posReceivedFailed: '121',
  DeliverectOrderStatus.parseFailed: '124'
};
