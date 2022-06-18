import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'feedback_slider_state.dart';

class FeedbackSliderCubit extends Cubit<FeedbackSliderState> {
  FeedbackSliderCubit(double value)
      : super(
          FeedbackSliderState(
            hasChanged: false,
            value: value,
          ),
        );

  void updateValue(double value) {
    emit(
      FeedbackSliderState(
        hasChanged: true,
        value: value,
      ),
    );
  }
}
