part of 'feedback_slider_cubit.dart';

class FeedbackSliderState extends Equatable {
  const FeedbackSliderState(this.value);

  final double value;

  @override
  List<Object> get props => [value];
}
