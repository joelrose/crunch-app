import 'package:flutter_test/flutter_test.dart';
import 'package:pickup/screens/discover/discover.dart';

import '../../../helpers/helpers.dart';

void main() {
  group(
    'DiscoverPage',
    () {
      testWidgets('renders DiscoverView', (tester) async {
        await tester.pumpApp(
          const DiscoverPage(),
        );

        expect(find.byType(DiscoverView), findsOneWidget);
      });
    },
  );
}
