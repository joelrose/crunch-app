import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pickup/screens/home/home.dart';

void main() {
  group('HomeCubit', () {
    blocTest<HomeCubit, HomeState>(
      'emits discover when nothing is called',
      build: () => HomeCubit(),
      expect: () => [],
      verify: (b) => b.state.tab == HomeTab.discover,
    );

    blocTest<HomeCubit, HomeState>(
      'emits HomeTab when emit is called',
      build: () => HomeCubit(),
      act: (cubit) => cubit.emit(const HomeState(tab: HomeTab.friends)),
      expect: () => const [HomeState(tab: HomeTab.friends)],
      verify: (b) => b.state.tab == HomeTab.friends,
    );

    blocTest<HomeCubit, HomeState>(
      'emits HomeTab when emit is called',
      build: () => HomeCubit(),
      act: (cubit) => cubit.setTab(HomeTab.vouchers),
      expect: () => const [HomeState(tab: HomeTab.vouchers)],
      verify: (b) => b.state.tab == HomeTab.vouchers,
    );
  });
}
