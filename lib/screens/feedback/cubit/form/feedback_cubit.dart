import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

part 'feedback_state.dart';

class FeedbackCubit extends Cubit<FeedbackState> {
  FeedbackCubit() : super(const FeedbackState());

  // submit form to server
  Future<void> submitFeedback({
    required double value,
  }) async {
    emit(state.copyWith(status: FeedbackStatus.loading));

    try {
      final url = Uri.parse(dotenv.get('FEEDBACK_URL'));
      final response = await http.post(
        url,
        body: {
          'value': value.toString(),
          'text': state.text,
        },
      );

      if (response.statusCode == 302) {
        emit(state.copyWith(status: FeedbackStatus.submitted));
      } else {
        emit(state.copyWith(status: FeedbackStatus.failed));
      }
    } catch (e) {
      emit(state.copyWith(status: FeedbackStatus.failed));
    }
  }

  void updateText(String text) {
    emit(
      state.copyWith(text: text),
    );
  }
}
