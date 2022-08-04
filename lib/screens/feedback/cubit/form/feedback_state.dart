part of 'feedback_cubit.dart';

enum FeedbackStatus {
  initial,
  loading,
  submitted,
  failed,
}

extension FeedbackStatusX on FeedbackStatus {
  bool get isInitial => this == FeedbackStatus.initial;
  bool get isLoading => this == FeedbackStatus.loading;
  bool get isSubmitted => this == FeedbackStatus.submitted;
  bool get isFailed => this == FeedbackStatus.failed;
}

class FeedbackState extends Equatable {
  const FeedbackState({
    this.status = FeedbackStatus.initial,
    this.text = '',
  });

  final FeedbackStatus status;
  final String text;

  FeedbackState copyWith({
    FeedbackStatus? status,
    String? text,
  }) {
    return FeedbackState(
      status: status ?? this.status,
      text: text ?? this.text,
    );
  }

  @override
  List<Object> get props => [status];
}
