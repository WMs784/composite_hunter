// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'timer_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TimerState {
  int get remainingSeconds => throw _privateConstructorUsedError;
  int get originalSeconds => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  bool get isWarning => throw _privateConstructorUsedError;
  List<TimePenalty> get penalties => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TimerStateCopyWith<TimerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimerStateCopyWith<$Res> {
  factory $TimerStateCopyWith(
          TimerState value, $Res Function(TimerState) then) =
      _$TimerStateCopyWithImpl<$Res, TimerState>;
  @useResult
  $Res call(
      {int remainingSeconds,
      int originalSeconds,
      bool isActive,
      bool isWarning,
      List<TimePenalty> penalties});
}

/// @nodoc
class _$TimerStateCopyWithImpl<$Res, $Val extends TimerState>
    implements $TimerStateCopyWith<$Res> {
  _$TimerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? remainingSeconds = null,
    Object? originalSeconds = null,
    Object? isActive = null,
    Object? isWarning = null,
    Object? penalties = null,
  }) {
    return _then(_value.copyWith(
      remainingSeconds: null == remainingSeconds
          ? _value.remainingSeconds
          : remainingSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      originalSeconds: null == originalSeconds
          ? _value.originalSeconds
          : originalSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      isWarning: null == isWarning
          ? _value.isWarning
          : isWarning // ignore: cast_nullable_to_non_nullable
              as bool,
      penalties: null == penalties
          ? _value.penalties
          : penalties // ignore: cast_nullable_to_non_nullable
              as List<TimePenalty>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TimerStateImplCopyWith<$Res>
    implements $TimerStateCopyWith<$Res> {
  factory _$$TimerStateImplCopyWith(
          _$TimerStateImpl value, $Res Function(_$TimerStateImpl) then) =
      __$$TimerStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int remainingSeconds,
      int originalSeconds,
      bool isActive,
      bool isWarning,
      List<TimePenalty> penalties});
}

/// @nodoc
class __$$TimerStateImplCopyWithImpl<$Res>
    extends _$TimerStateCopyWithImpl<$Res, _$TimerStateImpl>
    implements _$$TimerStateImplCopyWith<$Res> {
  __$$TimerStateImplCopyWithImpl(
      _$TimerStateImpl _value, $Res Function(_$TimerStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? remainingSeconds = null,
    Object? originalSeconds = null,
    Object? isActive = null,
    Object? isWarning = null,
    Object? penalties = null,
  }) {
    return _then(_$TimerStateImpl(
      remainingSeconds: null == remainingSeconds
          ? _value.remainingSeconds
          : remainingSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      originalSeconds: null == originalSeconds
          ? _value.originalSeconds
          : originalSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      isWarning: null == isWarning
          ? _value.isWarning
          : isWarning // ignore: cast_nullable_to_non_nullable
              as bool,
      penalties: null == penalties
          ? _value._penalties
          : penalties // ignore: cast_nullable_to_non_nullable
              as List<TimePenalty>,
    ));
  }
}

/// @nodoc

class _$TimerStateImpl extends _TimerState {
  const _$TimerStateImpl(
      {required this.remainingSeconds,
      required this.originalSeconds,
      this.isActive = false,
      this.isWarning = false,
      final List<TimePenalty> penalties = const []})
      : _penalties = penalties,
        super._();

  @override
  final int remainingSeconds;
  @override
  final int originalSeconds;
  @override
  @JsonKey()
  final bool isActive;
  @override
  @JsonKey()
  final bool isWarning;
  final List<TimePenalty> _penalties;
  @override
  @JsonKey()
  List<TimePenalty> get penalties {
    if (_penalties is EqualUnmodifiableListView) return _penalties;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_penalties);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimerStateImpl &&
            (identical(other.remainingSeconds, remainingSeconds) ||
                other.remainingSeconds == remainingSeconds) &&
            (identical(other.originalSeconds, originalSeconds) ||
                other.originalSeconds == originalSeconds) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.isWarning, isWarning) ||
                other.isWarning == isWarning) &&
            const DeepCollectionEquality()
                .equals(other._penalties, _penalties));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      remainingSeconds,
      originalSeconds,
      isActive,
      isWarning,
      const DeepCollectionEquality().hash(_penalties));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TimerStateImplCopyWith<_$TimerStateImpl> get copyWith =>
      __$$TimerStateImplCopyWithImpl<_$TimerStateImpl>(this, _$identity);
}

abstract class _TimerState extends TimerState {
  const factory _TimerState(
      {required final int remainingSeconds,
      required final int originalSeconds,
      final bool isActive,
      final bool isWarning,
      final List<TimePenalty> penalties}) = _$TimerStateImpl;
  const _TimerState._() : super._();

  @override
  int get remainingSeconds;
  @override
  int get originalSeconds;
  @override
  bool get isActive;
  @override
  bool get isWarning;
  @override
  List<TimePenalty> get penalties;
  @override
  @JsonKey(ignore: true)
  _$$TimerStateImplCopyWith<_$TimerStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
