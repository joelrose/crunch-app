import 'package:flutter_test/flutter_test.dart';
import 'package:pickup/screens/profile/cubit/profile_cubit.dart';

void main() {
  group(
    'ProfileState',
    () {
      // initial state
      test(
        'equality works as expected',
        () {
          expect(
            const ProfileState(status: ProfileStatus.initial),
            const ProfileState(status: ProfileStatus.initial),
          );
        },
      );

      test(
        'non equality works as expected',
        () {
          expect(
            const ProfileState(status: ProfileStatus.initial),
            isNot(const ProfileState(status: ProfileStatus.loading)),
          );
        },
      );
    },
  );
}
