import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

abstract class MyFunction {
  Future<void> call();
}

class FutureCallbackMock extends Mock implements MyFunction {}

@GenerateMocks([FutureCallbackMock])
void main() {
  testWidgets('Show Async Loading', (tester) async {
  await tester.runAsync(() async {
      final onPressed = FutureCallbackMock().call;

      final completer = Completer<void>();
      final future = completer.future;

      when(onPressed()).thenAnswer((_) => future);

      onPressed();

      completer.complete();

      verify(onPressed).called(1);
    });
  });
}
