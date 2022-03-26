import 'package:hermes_api/hermes_api.dart';

extension DeliverectOrderStatusExtension on DeliverectOrderStatus {
  String get string {
    switch (this) {
      case DeliverectOrderStatus.accepted:
        return 'Accepted';
      case DeliverectOrderStatus.autoFinalized:
        return 'Auto Finalized';
      case DeliverectOrderStatus.cancel:
        return 'Cancel';
      case DeliverectOrderStatus.canceled:
        return 'Canceled';
      case DeliverectOrderStatus.duplicate:
        return 'Duplicate';
      case DeliverectOrderStatus.failed:
        return 'Failed';
      case DeliverectOrderStatus.finalized:
        return 'Finalized';
      case DeliverectOrderStatus.indelivery:
        return 'In Delivery';
      case DeliverectOrderStatus.parseFailed:
        return 'Parse Failed';
      case DeliverectOrderStatus.parsed:
        return 'Parsed';
      case DeliverectOrderStatus.posReceivedFailed:
        return 'Pos Received Failed';
      case DeliverectOrderStatus.prepared:
        return 'Prepared';
      case DeliverectOrderStatus.preparing:
        return 'Preparing';
      case DeliverectOrderStatus.printed:
        return 'Printed';
      case DeliverectOrderStatus.readyForPickup:
        return 'Ready for Pickup';
      case DeliverectOrderStatus.received:
        return 'Received';
      case DeliverectOrderStatus.$new:
        return 'New';
      case DeliverectOrderStatus.swaggerGeneratedUnknown:
        return 'Undefined';
    }
  }
}
