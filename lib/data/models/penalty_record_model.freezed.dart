// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'penalty_record_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PenaltyRecordModel _$PenaltyRecordModelFromJson(Map<String, dynamic> json) {
  return _PenaltyRecordModel.fromJson(json);
}

/// @nodoc
mixin _$PenaltyRecordModel {
  int get seconds => throw _privateConstructorUsedError;
  PenaltyType get type => throw _privateConstructorUsedError;
  DateTime get appliedAt => throw _privateConstructorUsedError;
  String? get reason => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PenaltyRecordModelCopyWith<PenaltyRecordModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PenaltyRecordModelCopyWith<$Res> {
  factory $PenaltyRecordModelCopyWith(
    PenaltyRecordModel value,
    $Res Function(PenaltyRecordModel) then,
  ) = _$PenaltyRecordModelCopyWithImpl<$Res, PenaltyRecordModel>;
  @useResult
  $Res call({
    int seconds,
    PenaltyType type,
    DateTime appliedAt,
    String? reason,
  });
}

/// @nodoc
class _$PenaltyRecordModelCopyWithImpl<$Res, $Val extends PenaltyRecordModel>
    implements $PenaltyRecordModelCopyWith<$Res> {
  _$PenaltyRecordModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? seconds = null,
    Object? type = null,
    Object? appliedAt = null,
    Object? reason = freezed,
  }) {
    return _then(
      _value.copyWith(
            seconds: null == seconds
                ? _value.seconds
                : seconds // ignore: cast_nullable_to_non_nullable
                      as int,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as PenaltyType,
            appliedAt: null == appliedAt
                ? _value.appliedAt
                : appliedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            reason: freezed == reason
                ? _value.reason
                : reason // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PenaltyRecordModelImplCopyWith<$Res>
    implements $PenaltyRecordModelCopyWith<$Res> {
  factory _$$PenaltyRecordModelImplCopyWith(
    _$PenaltyRecordModelImpl value,
    $Res Function(_$PenaltyRecordModelImpl) then,
  ) = _$$PenaltyRecordModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int seconds,
    PenaltyType type,
    DateTime appliedAt,
    String? reason,
  });
}

/// @nodoc
class _$$PenaltyRecordModelImplCopyWithImpl<$Res>
    extends _$PenaltyRecordModelCopyWithImpl<$Res, _$PenaltyRecordModelImpl>
    implements _$$PenaltyRecordModelImplCopyWith<$Res> {
  _$$PenaltyRecordModelImplCopyWithImpl(
    _$PenaltyRecordModelImpl _value,
    $Res Function(_$PenaltyRecordModelImpl) _then,
  ) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? seconds = null,
    Object? type = null,
    Object? appliedAt = null,
    Object? reason = freezed,
  }) {
    return _then(
      _$PenaltyRecordModelImpl(
        seconds: null == seconds
            ? _value.seconds
            : seconds // ignore: cast_nullable_to_non_nullable
                  as int,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as PenaltyType,
        appliedAt: null == appliedAt
            ? _value.appliedAt
            : appliedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        reason: freezed == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PenaltyRecordModelImpl implements _PenaltyRecordModel {
  const _$PenaltyRecordModelImpl({
    required this.seconds,
    required this.type,
    required this.appliedAt,
    this.reason,
  });

  factory _$PenaltyRecordModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PenaltyRecordModelImplFromJson(json);

  @override
  final int seconds;
  @override
  final PenaltyType type;
  @override
  final DateTime appliedAt;
  @override
  final String? reason;

  @override
  String toString() {
    return 'PenaltyRecordModel(seconds: $seconds, type: $type, appliedAt: $appliedAt, reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PenaltyRecordModelImpl &&
            (identical(other.seconds, seconds) || other.seconds == seconds) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.appliedAt, appliedAt) ||
                other.appliedAt == appliedAt) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, seconds, type, appliedAt, reason);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PenaltyRecordModelImplCopyWith<_$PenaltyRecordModelImpl> get copyWith =>
      _$$PenaltyRecordModelImplCopyWithImpl<_$PenaltyRecordModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PenaltyRecordModelImplToJson(this);
  }
}

abstract class _PenaltyRecordModel implements PenaltyRecordModel {
  const factory _PenaltyRecordModel({
    required final int seconds,
    required final PenaltyType type,
    required final DateTime appliedAt,
    final String? reason,
  }) = _$PenaltyRecordModelImpl;

  factory _PenaltyRecordModel.fromJson(Map<String, dynamic> json) =
      _$PenaltyRecordModelImpl.fromJson;

  @override
  int get seconds;
  @override
  PenaltyType get type;
  @override
  DateTime get appliedAt;
  @override
  String? get reason;
  @override
  @JsonKey(ignore: true)
  _$$PenaltyRecordModelImplCopyWith<_$PenaltyRecordModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
