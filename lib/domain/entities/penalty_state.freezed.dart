// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'penalty_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$TimePenalty {
  int get seconds => throw _privateConstructorUsedError;
  PenaltyType get type => throw _privateConstructorUsedError;
  DateTime get appliedAt => throw _privateConstructorUsedError;
  String? get reason => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TimePenaltyCopyWith<TimePenalty> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimePenaltyCopyWith<$Res> {
  factory $TimePenaltyCopyWith(
    TimePenalty value,
    $Res Function(TimePenalty) then,
  ) = _$TimePenaltyCopyWithImpl<$Res, TimePenalty>;
  @useResult
  $Res call({
    int seconds,
    PenaltyType type,
    DateTime appliedAt,
    String? reason,
  });
}

/// @nodoc
class _$TimePenaltyCopyWithImpl<$Res, $Val extends TimePenalty>
    implements $TimePenaltyCopyWith<$Res> {
  _$TimePenaltyCopyWithImpl(this._value, this._then);

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
abstract class _$$TimePenaltyImplCopyWith<$Res>
    implements $TimePenaltyCopyWith<$Res> {
  factory _$$TimePenaltyImplCopyWith(
    _$TimePenaltyImpl value,
    $Res Function(_$TimePenaltyImpl) then,
  ) = _$$TimePenaltyImplCopyWithImpl<$Res>;
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
class _$$TimePenaltyImplCopyWithImpl<$Res>
    extends _$TimePenaltyCopyWithImpl<$Res, _$TimePenaltyImpl>
    implements _$$TimePenaltyImplCopyWith<$Res> {
  _$$TimePenaltyImplCopyWithImpl(
    _$TimePenaltyImpl _value,
    $Res Function(_$TimePenaltyImpl) _then,
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
      _$TimePenaltyImpl(
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

class _$TimePenaltyImpl extends _TimePenalty {
  const _$TimePenaltyImpl({
    required this.seconds,
    required this.type,
    required this.appliedAt,
    this.reason,
  }) : super._();

  @override
  final int seconds;
  @override
  final PenaltyType type;
  @override
  final DateTime appliedAt;
  @override
  final String? reason;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimePenaltyImpl &&
            (identical(other.seconds, seconds) || other.seconds == seconds) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.appliedAt, appliedAt) ||
                other.appliedAt == appliedAt) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, seconds, type, appliedAt, reason);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TimePenaltyImplCopyWith<_$TimePenaltyImpl> get copyWith =>
      _$$TimePenaltyImplCopyWithImpl<_$TimePenaltyImpl>(this, _$identity);
}

abstract class _TimePenalty extends TimePenalty {
  const factory _TimePenalty({
    required final int seconds,
    required final PenaltyType type,
    required final DateTime appliedAt,
    final String? reason,
  }) = _$TimePenaltyImpl;
  const _TimePenalty._() : super._();

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
  _$$TimePenaltyImplCopyWith<_$TimePenaltyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PenaltyState {
  List<TimePenalty> get activePenalties => throw _privateConstructorUsedError;
  int get totalPenaltySeconds => throw _privateConstructorUsedError;
  int get consecutiveEscapes => throw _privateConstructorUsedError;
  int get consecutiveWrongClaims => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PenaltyStateCopyWith<PenaltyState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PenaltyStateCopyWith<$Res> {
  factory $PenaltyStateCopyWith(
    PenaltyState value,
    $Res Function(PenaltyState) then,
  ) = _$PenaltyStateCopyWithImpl<$Res, PenaltyState>;
  @useResult
  $Res call({
    List<TimePenalty> activePenalties,
    int totalPenaltySeconds,
    int consecutiveEscapes,
    int consecutiveWrongClaims,
  });
}

/// @nodoc
class _$PenaltyStateCopyWithImpl<$Res, $Val extends PenaltyState>
    implements $PenaltyStateCopyWith<$Res> {
  _$PenaltyStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activePenalties = null,
    Object? totalPenaltySeconds = null,
    Object? consecutiveEscapes = null,
    Object? consecutiveWrongClaims = null,
  }) {
    return _then(
      _value.copyWith(
            activePenalties: null == activePenalties
                ? _value.activePenalties
                : activePenalties // ignore: cast_nullable_to_non_nullable
                      as List<TimePenalty>,
            totalPenaltySeconds: null == totalPenaltySeconds
                ? _value.totalPenaltySeconds
                : totalPenaltySeconds // ignore: cast_nullable_to_non_nullable
                      as int,
            consecutiveEscapes: null == consecutiveEscapes
                ? _value.consecutiveEscapes
                : consecutiveEscapes // ignore: cast_nullable_to_non_nullable
                      as int,
            consecutiveWrongClaims: null == consecutiveWrongClaims
                ? _value.consecutiveWrongClaims
                : consecutiveWrongClaims // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PenaltyStateImplCopyWith<$Res>
    implements $PenaltyStateCopyWith<$Res> {
  factory _$$PenaltyStateImplCopyWith(
    _$PenaltyStateImpl value,
    $Res Function(_$PenaltyStateImpl) then,
  ) = _$$PenaltyStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<TimePenalty> activePenalties,
    int totalPenaltySeconds,
    int consecutiveEscapes,
    int consecutiveWrongClaims,
  });
}

/// @nodoc
class _$$PenaltyStateImplCopyWithImpl<$Res>
    extends _$PenaltyStateCopyWithImpl<$Res, _$PenaltyStateImpl>
    implements _$$PenaltyStateImplCopyWith<$Res> {
  _$$PenaltyStateImplCopyWithImpl(
    _$PenaltyStateImpl _value,
    $Res Function(_$PenaltyStateImpl) _then,
  ) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activePenalties = null,
    Object? totalPenaltySeconds = null,
    Object? consecutiveEscapes = null,
    Object? consecutiveWrongClaims = null,
  }) {
    return _then(
      _$PenaltyStateImpl(
        activePenalties: null == activePenalties
            ? _value._activePenalties
            : activePenalties // ignore: cast_nullable_to_non_nullable
                  as List<TimePenalty>,
        totalPenaltySeconds: null == totalPenaltySeconds
            ? _value.totalPenaltySeconds
            : totalPenaltySeconds // ignore: cast_nullable_to_non_nullable
                  as int,
        consecutiveEscapes: null == consecutiveEscapes
            ? _value.consecutiveEscapes
            : consecutiveEscapes // ignore: cast_nullable_to_non_nullable
                  as int,
        consecutiveWrongClaims: null == consecutiveWrongClaims
            ? _value.consecutiveWrongClaims
            : consecutiveWrongClaims // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$PenaltyStateImpl extends _PenaltyState {
  const _$PenaltyStateImpl({
    final List<TimePenalty> activePenalties = const [],
    this.totalPenaltySeconds = 0,
    this.consecutiveEscapes = 0,
    this.consecutiveWrongClaims = 0,
  }) : _activePenalties = activePenalties,
       super._();

  final List<TimePenalty> _activePenalties;
  @override
  @JsonKey()
  List<TimePenalty> get activePenalties {
    if (_activePenalties is EqualUnmodifiableListView) return _activePenalties;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_activePenalties);
  }

  @override
  @JsonKey()
  final int totalPenaltySeconds;
  @override
  @JsonKey()
  final int consecutiveEscapes;
  @override
  @JsonKey()
  final int consecutiveWrongClaims;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PenaltyStateImpl &&
            const DeepCollectionEquality().equals(
              other._activePenalties,
              _activePenalties,
            ) &&
            (identical(other.totalPenaltySeconds, totalPenaltySeconds) ||
                other.totalPenaltySeconds == totalPenaltySeconds) &&
            (identical(other.consecutiveEscapes, consecutiveEscapes) ||
                other.consecutiveEscapes == consecutiveEscapes) &&
            (identical(other.consecutiveWrongClaims, consecutiveWrongClaims) ||
                other.consecutiveWrongClaims == consecutiveWrongClaims));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_activePenalties),
    totalPenaltySeconds,
    consecutiveEscapes,
    consecutiveWrongClaims,
  );

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PenaltyStateImplCopyWith<_$PenaltyStateImpl> get copyWith =>
      _$$PenaltyStateImplCopyWithImpl<_$PenaltyStateImpl>(this, _$identity);
}

abstract class _PenaltyState extends PenaltyState {
  const factory _PenaltyState({
    final List<TimePenalty> activePenalties,
    final int totalPenaltySeconds,
    final int consecutiveEscapes,
    final int consecutiveWrongClaims,
  }) = _$PenaltyStateImpl;
  const _PenaltyState._() : super._();

  @override
  List<TimePenalty> get activePenalties;
  @override
  int get totalPenaltySeconds;
  @override
  int get consecutiveEscapes;
  @override
  int get consecutiveWrongClaims;
  @override
  @JsonKey(ignore: true)
  _$$PenaltyStateImplCopyWith<_$PenaltyStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
