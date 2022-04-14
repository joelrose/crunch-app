import 'package:hermes_api/swagger_generated_code/swagger.swagger.dart';
import 'package:pickup/shared/extensions.dart';
import 'package:test/test.dart';

void main() {
  test('DeliverectOrderStatus Extension ', () {
    expect(DeliverectOrderStatus.accepted.string, 'Accepted');
    expect(DeliverectOrderStatus.autoFinalized.string, 'Auto Finalized');
    expect(DeliverectOrderStatus.cancel.string, 'Cancel');
    expect(DeliverectOrderStatus.canceled.string, 'Canceled');
    expect(DeliverectOrderStatus.duplicate.string, 'Duplicate');
    expect(DeliverectOrderStatus.failed.string, 'Failed');
    expect(DeliverectOrderStatus.finalized.string, 'Finalized');
    expect(DeliverectOrderStatus.indelivery.string, 'In Delivery');
    expect(DeliverectOrderStatus.parseFailed.string, 'Parse Failed');
    expect(DeliverectOrderStatus.parsed.string, 'Parsed');
    expect(DeliverectOrderStatus.posReceivedFailed.string, 'Pos Received Failed');
    expect(DeliverectOrderStatus.prepared.string, 'Prepared');
    expect(DeliverectOrderStatus.printed.string, 'Printed');
    expect(DeliverectOrderStatus.readyForPickup.string, 'Ready for Pickup');
    expect(DeliverectOrderStatus.received.string, 'Received');
    expect(DeliverectOrderStatus.swaggerGeneratedUnknown.string, 'Undefined');
    expect(DeliverectOrderStatus.$new.string, 'New');
  });
}
