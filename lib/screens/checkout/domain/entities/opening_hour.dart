import 'package:equatable/equatable.dart';

class OpeningHour extends Equatable {
  const OpeningHour(this.hour, this.minutes);

  final int hour;
  final List<int> minutes;

  @override
  List<Object?> get props => [hour, minutes];
}
