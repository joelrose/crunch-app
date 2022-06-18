part of 'feedback_slider_cubit.dart';

class FeedbackSliderState extends Equatable {
  const FeedbackSliderState({
    required this.value,
    required this.hasChanged,
  });

  final double value;
  final bool hasChanged;

  FeedbackSliderState copyWith({
    double? value,
    bool? hasChanged,
  }) {
    return FeedbackSliderState(
      value: value ?? this.value,
      hasChanged: hasChanged ?? this.hasChanged,
    );
  }

  @override
  List<Object> get props => [value];
}
