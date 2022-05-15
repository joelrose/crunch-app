// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'checkout_time_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CheckoutTimeState {
  DateTime get pickupTime => throw _privateConstructorUsedError;
  OpeningHour get currentSelectedHour => throw _privateConstructorUsedError;
  int get currentSelectedMinuteIndex => throw _privateConstructorUsedError;
  List<OpeningHour> get availableOpeningTimes =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            DateTime pickupTime,
            OpeningHour currentSelectedHour,
            int currentSelectedMinuteIndex,
            List<OpeningHour> availableOpeningTimes)
        static,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(
            DateTime pickupTime,
            OpeningHour currentSelectedHour,
            int currentSelectedMinuteIndex,
            List<OpeningHour> availableOpeningTimes)?
        static,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            DateTime pickupTime,
            OpeningHour currentSelectedHour,
            int currentSelectedMinuteIndex,
            List<OpeningHour> availableOpeningTimes)?
        static,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Static value) static,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Static value)? static,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Static value)? static,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CheckoutTimeStateCopyWith<CheckoutTimeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckoutTimeStateCopyWith<$Res> {
  factory $CheckoutTimeStateCopyWith(
          CheckoutTimeState value, $Res Function(CheckoutTimeState) then) =
      _$CheckoutTimeStateCopyWithImpl<$Res>;
  $Res call(
      {DateTime pickupTime,
      OpeningHour currentSelectedHour,
      int currentSelectedMinuteIndex,
      List<OpeningHour> availableOpeningTimes});
}

/// @nodoc
class _$CheckoutTimeStateCopyWithImpl<$Res>
    implements $CheckoutTimeStateCopyWith<$Res> {
  _$CheckoutTimeStateCopyWithImpl(this._value, this._then);

  final CheckoutTimeState _value;
  // ignore: unused_field
  final $Res Function(CheckoutTimeState) _then;

  @override
  $Res call({
    Object? pickupTime = freezed,
    Object? currentSelectedHour = freezed,
    Object? currentSelectedMinuteIndex = freezed,
    Object? availableOpeningTimes = freezed,
  }) {
    return _then(_value.copyWith(
      pickupTime: pickupTime == freezed
          ? _value.pickupTime
          : pickupTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      currentSelectedHour: currentSelectedHour == freezed
          ? _value.currentSelectedHour
          : currentSelectedHour // ignore: cast_nullable_to_non_nullable
              as OpeningHour,
      currentSelectedMinuteIndex: currentSelectedMinuteIndex == freezed
          ? _value.currentSelectedMinuteIndex
          : currentSelectedMinuteIndex // ignore: cast_nullable_to_non_nullable
              as int,
      availableOpeningTimes: availableOpeningTimes == freezed
          ? _value.availableOpeningTimes
          : availableOpeningTimes // ignore: cast_nullable_to_non_nullable
              as List<OpeningHour>,
    ));
  }
}

/// @nodoc
abstract class _$$_StaticCopyWith<$Res>
    implements $CheckoutTimeStateCopyWith<$Res> {
  factory _$$_StaticCopyWith(_$_Static value, $Res Function(_$_Static) then) =
      __$$_StaticCopyWithImpl<$Res>;
  @override
  $Res call(
      {DateTime pickupTime,
      OpeningHour currentSelectedHour,
      int currentSelectedMinuteIndex,
      List<OpeningHour> availableOpeningTimes});
}

/// @nodoc
class __$$_StaticCopyWithImpl<$Res>
    extends _$CheckoutTimeStateCopyWithImpl<$Res>
    implements _$$_StaticCopyWith<$Res> {
  __$$_StaticCopyWithImpl(_$_Static _value, $Res Function(_$_Static) _then)
      : super(_value, (v) => _then(v as _$_Static));

  @override
  _$_Static get _value => super._value as _$_Static;

  @override
  $Res call({
    Object? pickupTime = freezed,
    Object? currentSelectedHour = freezed,
    Object? currentSelectedMinuteIndex = freezed,
    Object? availableOpeningTimes = freezed,
  }) {
    return _then(_$_Static(
      pickupTime == freezed
          ? _value.pickupTime
          : pickupTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      currentSelectedHour == freezed
          ? _value.currentSelectedHour
          : currentSelectedHour // ignore: cast_nullable_to_non_nullable
              as OpeningHour,
      currentSelectedMinuteIndex == freezed
          ? _value.currentSelectedMinuteIndex
          : currentSelectedMinuteIndex // ignore: cast_nullable_to_non_nullable
              as int,
      availableOpeningTimes == freezed
          ? _value._availableOpeningTimes
          : availableOpeningTimes // ignore: cast_nullable_to_non_nullable
              as List<OpeningHour>,
    ));
  }
}

/// @nodoc

class _$_Static implements _Static {
  const _$_Static(
      this.pickupTime,
      this.currentSelectedHour,
      this.currentSelectedMinuteIndex,
      final List<OpeningHour> availableOpeningTimes)
      : _availableOpeningTimes = availableOpeningTimes;

  @override
  final DateTime pickupTime;
  @override
  final OpeningHour currentSelectedHour;
  @override
  final int currentSelectedMinuteIndex;
  final List<OpeningHour> _availableOpeningTimes;
  @override
  List<OpeningHour> get availableOpeningTimes {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableOpeningTimes);
  }

  @override
  String toString() {
    return 'CheckoutTimeState.static(pickupTime: $pickupTime, currentSelectedHour: $currentSelectedHour, currentSelectedMinuteIndex: $currentSelectedMinuteIndex, availableOpeningTimes: $availableOpeningTimes)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Static &&
            const DeepCollectionEquality()
                .equals(other.pickupTime, pickupTime) &&
            const DeepCollectionEquality()
                .equals(other.currentSelectedHour, currentSelectedHour) &&
            const DeepCollectionEquality().equals(
                other.currentSelectedMinuteIndex, currentSelectedMinuteIndex) &&
            const DeepCollectionEquality()
                .equals(other._availableOpeningTimes, _availableOpeningTimes));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(pickupTime),
      const DeepCollectionEquality().hash(currentSelectedHour),
      const DeepCollectionEquality().hash(currentSelectedMinuteIndex),
      const DeepCollectionEquality().hash(_availableOpeningTimes));

  @JsonKey(ignore: true)
  @override
  _$$_StaticCopyWith<_$_Static> get copyWith =>
      __$$_StaticCopyWithImpl<_$_Static>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            DateTime pickupTime,
            OpeningHour currentSelectedHour,
            int currentSelectedMinuteIndex,
            List<OpeningHour> availableOpeningTimes)
        static,
  }) {
    return static(pickupTime, currentSelectedHour, currentSelectedMinuteIndex,
        availableOpeningTimes);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(
            DateTime pickupTime,
            OpeningHour currentSelectedHour,
            int currentSelectedMinuteIndex,
            List<OpeningHour> availableOpeningTimes)?
        static,
  }) {
    return static?.call(pickupTime, currentSelectedHour,
        currentSelectedMinuteIndex, availableOpeningTimes);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            DateTime pickupTime,
            OpeningHour currentSelectedHour,
            int currentSelectedMinuteIndex,
            List<OpeningHour> availableOpeningTimes)?
        static,
    required TResult orElse(),
  }) {
    if (static != null) {
      return static(pickupTime, currentSelectedHour, currentSelectedMinuteIndex,
          availableOpeningTimes);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Static value) static,
  }) {
    return static(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Static value)? static,
  }) {
    return static?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Static value)? static,
    required TResult orElse(),
  }) {
    if (static != null) {
      return static(this);
    }
    return orElse();
  }
}

abstract class _Static implements CheckoutTimeState {
  const factory _Static(
      final DateTime pickupTime,
      final OpeningHour currentSelectedHour,
      final int currentSelectedMinuteIndex,
      final List<OpeningHour> availableOpeningTimes) = _$_Static;

  @override
  DateTime get pickupTime => throw _privateConstructorUsedError;
  @override
  OpeningHour get currentSelectedHour => throw _privateConstructorUsedError;
  @override
  int get currentSelectedMinuteIndex => throw _privateConstructorUsedError;
  @override
  List<OpeningHour> get availableOpeningTimes =>
      throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_StaticCopyWith<_$_Static> get copyWith =>
      throw _privateConstructorUsedError;
}
