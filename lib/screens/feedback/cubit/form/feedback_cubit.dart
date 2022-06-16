import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'feedback_state.dart';

class FeedbackCubit extends Cubit<FeedbackState> {
  FeedbackCubit() : super(const FeedbackState());
}
