// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'victory_claim.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$VictoryClaim {
  int get claimedValue => throw _privateConstructorUsedError;
  DateTime get claimedAt => throw _privateConstructorUsedError;
  bool get isCorrect => throw _privateConstructorUsedError;
  int? get rewardPrime => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $VictoryClaimCopyWith<VictoryClaim> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VictoryClaimCopyWith<$Res> {
  factory $VictoryClaimCopyWith(
          VictoryClaim value, $Res Function(VictoryClaim) then) =
      _$VictoryClaimCopyWithImpl<$Res, VictoryClaim>;
  @useResult
  $Res call(
      {int claimedValue,
      DateTime claimedAt,
      bool isCorrect,
      int? rewardPrime,
      String? errorMessage});
}

/// @nodoc
class _$VictoryClaimCopyWithImpl<$Res, $Val extends VictoryClaim>
    implements $VictoryClaimCopyWith<$Res> {
  _$VictoryClaimCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? claimedValue = null,
    Object? claimedAt = null,
    Object? isCorrect = null,
    Object? rewardPrime = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      claimedValue: null == claimedValue
          ? _value.claimedValue
          : claimedValue // ignore: cast_nullable_to_non_nullable
              as int,
      claimedAt: null == claimedAt
          ? _value.claimedAt
          : claimedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isCorrect: null == isCorrect
          ? _value.isCorrect
          : isCorrect // ignore: cast_nullable_to_non_nullable
              as bool,
      rewardPrime: freezed == rewardPrime
          ? _value.rewardPrime
          : rewardPrime // ignore: cast_nullable_to_non_nullable
              as int?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VictoryClaimImplCopyWith<$Res>
    implements $VictoryClaimCopyWith<$Res> {
  factory _$$VictoryClaimImplCopyWith(
          _$VictoryClaimImpl value, $Res Function(_$VictoryClaimImpl) then) =
      __$$VictoryClaimImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int claimedValue,
      DateTime claimedAt,
      bool isCorrect,
      int? rewardPrime,
      String? errorMessage});
}

/// @nodoc
class __$$VictoryClaimImplCopyWithImpl<$Res>
    extends _$VictoryClaimCopyWithImpl<$Res, _$VictoryClaimImpl>
    implements _$$VictoryClaimImplCopyWith<$Res> {
  __$$VictoryClaimImplCopyWithImpl(
      _$VictoryClaimImpl _value, $Res Function(_$VictoryClaimImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? claimedValue = null,
    Object? claimedAt = null,
    Object? isCorrect = null,
    Object? rewardPrime = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_$VictoryClaimImpl(
      claimedValue: null == claimedValue
          ? _value.claimedValue
          : claimedValue // ignore: cast_nullable_to_non_nullable
              as int,
      claimedAt: null == claimedAt
          ? _value.claimedAt
          : claimedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isCorrect: null == isCorrect
          ? _value.isCorrect
          : isCorrect // ignore: cast_nullable_to_non_nullable
              as bool,
      rewardPrime: freezed == rewardPrime
          ? _value.rewardPrime
          : rewardPrime // ignore: cast_nullable_to_non_nullable
              as int?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$VictoryClaimImpl extends _VictoryClaim {
  const _$VictoryClaimImpl(
      {required this.claimedValue,
      required this.claimedAt,
      required this.isCorrect,
      this.rewardPrime,
      this.errorMessage})
      : super._();

  @override
  final int claimedValue;
  @override
  final DateTime claimedAt;
  @override
  final bool isCorrect;
  @override
  final int? rewardPrime;
  @override
  final String? errorMessage;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VictoryClaimImpl &&
            (identical(other.claimedValue, claimedValue) ||
                other.claimedValue == claimedValue) &&
            (identical(other.claimedAt, claimedAt) ||
                other.claimedAt == claimedAt) &&
            (identical(other.isCorrect, isCorrect) ||
                other.isCorrect == isCorrect) &&
            (identical(other.rewardPrime, rewardPrime) ||
                other.rewardPrime == rewardPrime) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, claimedValue, claimedAt,
      isCorrect, rewardPrime, errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VictoryClaimImplCopyWith<_$VictoryClaimImpl> get copyWith =>
      __$$VictoryClaimImplCopyWithImpl<_$VictoryClaimImpl>(this, _$identity);
}

abstract class _VictoryClaim extends VictoryClaim {
  const factory _VictoryClaim(
      {required final int claimedValue,
      required final DateTime claimedAt,
      required final bool isCorrect,
      final int? rewardPrime,
      final String? errorMessage}) = _$VictoryClaimImpl;
  const _VictoryClaim._() : super._();

  @override
  int get claimedValue;
  @override
  DateTime get claimedAt;
  @override
  bool get isCorrect;
  @override
  int? get rewardPrime;
  @override
  String? get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$VictoryClaimImplCopyWith<_$VictoryClaimImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
