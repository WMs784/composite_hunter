// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'timer_state_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TimerStateModel _$TimerStateModelFromJson(Map<String, dynamic> json) {
  return _TimerStateModel.fromJson(json);
}

/// @nodoc
mixin _$TimerStateModel {
  int get remainingSeconds => throw _privateConstructorUsedError;
  int get originalSeconds => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  bool get isWarning => throw _privateConstructorUsedError;
  List<PenaltyRecordModel> get penalties => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TimerStateModelCopyWith<TimerStateModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimerStateModelCopyWith<$Res> {
  factory $TimerStateModelCopyWith(
    TimerStateModel value,
    $Res Function(TimerStateModel) then,
  ) = _$TimerStateModelCopyWithImpl<$Res, TimerStateModel>;
  @useResult
  $Res call({
    int remainingSeconds,
    int originalSeconds,
    bool isActive,
    bool isWarning,
    List<PenaltyRecordModel> penalties,
  });
}

/// @nodoc
class _$TimerStateModelCopyWithImpl<$Res, $Val extends TimerStateModel>
    implements $TimerStateModelCopyWith<$Res> {
  _$TimerStateModelCopyWithImpl(this._value, this._then);

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
    return _then(
      _value.copyWith(
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
                      as List<PenaltyRecordModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TimerStateModelImplCopyWith<$Res>
    implements $TimerStateModelCopyWith<$Res> {
  factory _$$TimerStateModelImplCopyWith(
    _$TimerStateModelImpl value,
    $Res Function(_$TimerStateModelImpl) then,
  ) = _$$TimerStateModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int remainingSeconds,
    int originalSeconds,
    bool isActive,
    bool isWarning,
    List<PenaltyRecordModel> penalties,
  });
}

/// @nodoc
class _$$TimerStateModelImplCopyWithImpl<$Res>
    extends _$TimerStateModelCopyWithImpl<$Res, _$TimerStateModelImpl>
    implements _$$TimerStateModelImplCopyWith<$Res> {
  _$$TimerStateModelImplCopyWithImpl(
    _$TimerStateModelImpl _value,
    $Res Function(_$TimerStateModelImpl) _then,
  ) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? remainingSeconds = null,
    Object? originalSeconds = null,
    Object? isActive = null,
    Object? isWarning = null,
    Object? penalties = null,
  }) {
    return _then(
      _$TimerStateModelImpl(
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
                  as List<PenaltyRecordModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TimerStateModelImpl implements _TimerStateModel {
  const _$TimerStateModelImpl({
    required this.remainingSeconds,
    required this.originalSeconds,
    this.isActive = false,
    this.isWarning = false,
    final List<PenaltyRecordModel> penalties = const [],
  }) : _penalties = penalties;

  factory _$TimerStateModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimerStateModelImplFromJson(json);

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
  final List<PenaltyRecordModel> _penalties;
  @override
  @JsonKey()
  List<PenaltyRecordModel> get penalties {
    if (_penalties is EqualUnmodifiableListView) return _penalties;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_penalties);
  }

  @override
  String toString() {
    return 'TimerStateModel(remainingSeconds: $remainingSeconds, originalSeconds: $originalSeconds, isActive: $isActive, isWarning: $isWarning, penalties: $penalties)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimerStateModelImpl &&
            (identical(other.remainingSeconds, remainingSeconds) ||
                other.remainingSeconds == remainingSeconds) &&
            (identical(other.originalSeconds, originalSeconds) ||
                other.originalSeconds == originalSeconds) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.isWarning, isWarning) ||
                other.isWarning == isWarning) &&
            const DeepCollectionEquality().equals(
              other._penalties,
              _penalties,
            ));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    remainingSeconds,
    originalSeconds,
    isActive,
    isWarning,
    const DeepCollectionEquality().hash(_penalties),
  );

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TimerStateModelImplCopyWith<_$TimerStateModelImpl> get copyWith =>
      _$$TimerStateModelImplCopyWithImpl<_$TimerStateModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TimerStateModelImplToJson(this);
  }
}

abstract class _TimerStateModel implements TimerStateModel {
  const factory _TimerStateModel({
    required final int remainingSeconds,
    required final int originalSeconds,
    final bool isActive,
    final bool isWarning,
    final List<PenaltyRecordModel> penalties,
  }) = _$TimerStateModelImpl;

  factory _TimerStateModel.fromJson(Map<String, dynamic> json) =
      _$TimerStateModelImpl.fromJson;

  @override
  int get remainingSeconds;
  @override
  int get originalSeconds;
  @override
  bool get isActive;
  @override
  bool get isWarning;
  @override
  List<PenaltyRecordModel> get penalties;
  @override
  @JsonKey(ignore: true)
  _$$TimerStateModelImplCopyWith<_$TimerStateModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
