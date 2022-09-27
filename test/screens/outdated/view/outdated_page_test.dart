import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pickup/screens/outdated/view/outdated_page.dart';

import '../../../helpers/pump_app.dart';

void main() {
  group('OutdatedPage', () {
    test(
      'has route',
      () => expect(
        OutdatedPage.route(),
        isA<CupertinoPageRoute<void>>(),
      ),
    );

    testWidgets('renders View', (tester) async {
      await tester.pumpApp(
        Navigator(
          onGenerateRoute: (_) => OutdatedPage.route(),
        ),
      );
      
      expect(find.byType(SvgPicture), findsOneWidget);
    });
  });
}
