import 'package:pickup/screens/profile/cubit/profile_cubit.dart';
import 'package:test/test.dart';

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
