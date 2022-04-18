import 'package:fake_async/fake_async.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:pickup/screens/home/home.dart';
import 'package:pickup/screens/loading/loading.dart';
import 'package:pickup/screens/onboarding/welcome/welcome.dart';
import 'package:pickup/services/auth_service.dart';

import '../../helpers/helpers.dart';

class MockAuthService extends Mock implements AuthService {}

class MockUser extends Mock implements User {}

void main() {
  late MockAuthService mockAuthService;

  late MockNavigator navigator;

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();

    final GetIt locator = GetIt.instance;
    locator.allowReassignment = true;

    mockAuthService = MockAuthService();

    locator.registerSingleton<AuthService>(mockAuthService);

    navigator = MockNavigator();
  });

  group('Loading Widget Test', () {
    testWidgets('loading screen loaded', (tester) async {
      await tester.pumpApp(
        const LoadingScreen(),
      );
      expect(find.byType(SvgPicture), findsOneWidget);
    });

    testWidgets('loading screen loaded unauthenticated', (tester) async {
      when(() => mockAuthService.getUser).thenAnswer(
        (_) => Future.value(null),
      );

      when(() => navigator.pushNamedAndRemoveUntil<Object?>(any(), any()))
          .thenAnswer((_) async {});

      FakeAsync().run((fakeAsync) {
        tester.pumpApp(
          const LoadingScreen(),
          navigator: navigator,
        );
        fakeAsync.flushTimers();
      });

      verify(
        () => navigator.pushNamedAndRemoveUntil<Object?>(
          OnboardingWelcomeScreen.route,
          any(),
        ),
      ).called(1);
    });

    testWidgets('loading screen loaded authenticated', (tester) async {
      when(() => mockAuthService.getUser)
          .thenAnswer((_) => Future<MockUser>.value(MockUser()));

      when(() => navigator.pushNamedAndRemoveUntil<Object?>(any(), any()))
          .thenAnswer((_) async {});

      FakeAsync().run((fakeAsync) {
        tester.pumpApp(
          const LoadingScreen(),
          navigator: navigator,
        );
        fakeAsync.flushTimers();
      });

      verify(
        () => navigator.pushNamedAndRemoveUntil<Object?>(
          HomePage.route,
          any(),
        ),
      ).called(1);
    });
  });
}
