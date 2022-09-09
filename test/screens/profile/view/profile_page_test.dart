import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:pickup/screens/profile/cubit/profile_cubit.dart';
import 'package:pickup/screens/profile/view/profile_page.dart';
import 'package:pickup/screens/profile/widgets/profile_tile.dart';

import '../../../helpers/helpers.dart';

class MockProfileCubit extends Mock implements ProfileCubit {}

void main() {}
/*
void main() {
  group(
    'Profile page',
    () {
      
      // prepare every test
      setUp(() {
        // ...
      });

      testWidgets('page loads and shows content', (tester) async {
        await tester.pumpApp(ProfilePage());

        expect(find.byType(ProfileTile), findsNWidgets(5));
      });

      testWidgets('page loads ProfileView', (tester) async {
        await tester.pumpApp(ProfilePage());

        expect(find.byType(ProfileView), findsOneWidget);
      });

      group('logout button', () {
        testWidgets('navigates to login page on successful logout',
            (tester) async {
          final MockNavigator navigator = MockNavigator();

          when(() => navigator.pushAndRemoveUntil<void>(any(), any()))
              .thenAnswer((_) async {});

          final profileCubit = MockProfileCubit();

          whenListen(
            profileCubit,
            Stream.fromIterable([
              const ProfileState(status: ProfileStatus.loading),
              const ProfileState(status: ProfileStatus.loggedOut)
            ]),
          );

          when(() => profileCubit.state).thenAnswer(
            (i) => const ProfileState(status: ProfileStatus.loggedOut),
          );

          when(() => profileCubit.close()).thenAnswer((_) async {});

          await tester.pumpApp(
            BlocProvider<ProfileCubit>(
              create: (context) => profileCubit,
              child: const ProfileView(),
            ),
            navigator: navigator,
          );

          verify(
            () => navigator.pushAndRemoveUntil<void>(
              any(that: isRoute<void>()),
              any(),
            ),
          ).called(1);
        });

        testWidgets('calls logout method on tap', (tester) async {
          final profileCubit = MockProfileCubit();

          whenListen(
            profileCubit,
            Stream.fromIterable([
              const ProfileState(status: ProfileStatus.initial),
            ]),
          );

          when(() => profileCubit.state).thenAnswer(
            (i) => const ProfileState(status: ProfileStatus.initial),
          );

          when(() => profileCubit.logoutUser()).thenAnswer((_) async {});

          when(() => profileCubit.close()).thenAnswer((_) async {});

          await tester.pumpApp(
            BlocProvider<ProfileCubit>(
              create: (context) => profileCubit,
              child: const ProfileView(),
            ),
          );

          final logoutButton = find.byKey(
            const Key('logout_button'),
          );

          expect(logoutButton, findsOneWidget);

          await tester.tap(logoutButton);
          await tester.pumpAndSettle();

          verify(
            () => profileCubit.logoutUser(),
          ).called(1);
        });
      });
    },
  );
}
*/
