part of '../screens/app/cubit/user/user_cubit.dart';

enum BaseStatus { initial, loading, successful, failed }

extension BaseStatusX on BaseStatus {
  bool get isInitial => this == BaseStatus.initial;
  bool get isLoading => this == BaseStatus.loading;
  bool get isSuccessful => this == BaseStatus.successful;
  bool get isFailed => this == BaseStatus.failed;
} 

class BaseState<T> extends Equatable {
  const BaseState({this.status = BaseStatus.initial, this.model});

  final BaseStatus status;
  final T? model;

  BaseState copyWith({
    BaseStatus? status,
    T? model,
  }) {
    return BaseState(
      status: status ?? this.status,
      model: model ?? this.model,
    );
  }

  @override
  List<Object> get props => [status];
}
