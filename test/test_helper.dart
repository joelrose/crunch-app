import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:pickup/services/auth_service.dart';
import 'package:pickup/services/hermes_service.dart';

import 'mock/mock_hermes_service.dart';
import 'test_helper.mocks.dart';

@GenerateMocks(
  [User],
  customMocks: [
    MockSpec<NavigatorObserver>(returnNullOnMissingStub: true),
    MockSpec<AuthService>(returnNullOnMissingStub: true)
  ],
)
class TestHelper {
  static MockAuthService registerMockAuthService(GetIt locator) {
    final mockAuthService = MockAuthService();

    locator.registerSingleton<AuthService>(mockAuthService);
    locator.registerSingleton<HermesService>(MockHermesService('[]', 200));
    return mockAuthService;
  }

 /* static Future<bool> registerEasyLocalization() async {
    final content = await rootBundle.loadString('assets/translations/en.json');
    final data = jsonDecode(content) as Map<String, dynamic>;

    return Localization.load(
      const Locale('en'),
      translations: Translations(data),
    );
  }*/
}
